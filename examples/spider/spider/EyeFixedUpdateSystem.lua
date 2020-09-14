local heart = require("heart")

local M = heart.class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
end

function M:handleEvent(dt)
  local eyeEntities = self.engine.componentEntitySets.eye
  local transformComponents = self.engine.componentManagers.transform
  local physicsDomain = self.engine.domains.physics
  local world = physicsDomain.world
  local eyeComponents = self.engine.componentManagers.eye
  local targets = eyeComponents.targets
  local bodies = physicsDomain.bodies
  local parents = self.engine.entityParents

  for id in pairs(eyeEntities) do
    local x1, y1 = transformComponents:getTransform(id):getPosition()

    local angle = 2 * math.pi * love.math.random()
    local length = 2

    local x2 = x1 + length * math.cos(angle)
    local y2 = y1 + length * math.sin(angle)

    local targetFixture = nil
    local targetX = 0
    local targetY = 0
    local targetNormalX = 0
    local targetNormalY = -1

    local parentId = parents[id]
    local parentBody = bodies[parentId]

    world:rayCast(
      x1, y1, x2, y2,

      function(fixture, x, y, normalX, normalY, fraction)
        if fixture:getBody() == parentBody then
          return 1
        end

        targetFixture = fixture

        targetX = x
        targetY = y

        targetNormalX = normalX
        targetNormalY = normalY

        return fraction
      end)

    targets[id][1] = targetFixture

    targets[id][2] = targetX
    targets[id][3] = targetY

    targets[id][4] = targetNormalX
    targets[id][5] = targetNormalY
  end
end

return M
