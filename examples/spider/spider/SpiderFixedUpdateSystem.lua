local heart = require("heart")

local M = heart.class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
end

function M:handleEvent(dt)
  local world = self.engine.domains.physics.world
  local bodies = self.engine.domains.physics.bodies
  local distanceJoints = self.engine.domains.physics.distanceJoints
  local transformComponents = self.engine.componentManagers.transform
  local spiderEntities = self.engine.componentEntitySets.spider

  local upInput = love.keyboard.isDown("w")
  local leftInput = love.keyboard.isDown("a")
  local downInput = love.keyboard.isDown("s")
  local rightInput = love.keyboard.isDown("d")

  local inputX = (rightInput and 1 or 0) - (leftInput and 1 or 0)
  local inputY = (downInput and 1 or 0) - (upInput and 1 or 0)

  local dx = 10 * inputX * dt
  local dy = 10 * inputY * dt

  if inputX and inputY then
    inputX, inputY = heart.math.normalize2(inputX, inputY)
  end

  for id in pairs(spiderEntities) do
    local transform = transformComponents:getTransform(id)
    local x1, y1 = bodies[id]:getPosition()

    local angle = 2 * math.pi * love.math.random()
    local length = 2

    local x2 = x1 + length * math.cos(angle)
    local y2 = y1 + length * math.sin(angle)

    local groundFixture = nil
    local groundX = 0
    local groundY = 0
    local groundNormalX = 0
    local groundNormalY = -1

    world:rayCast(
      x1, y1, x2, y2,

      function(fixture, x, y, normalX, normalY, fraction)
        if false then
          return 1
        end

        groundFixture = fixture

        groundX = x
        groundY = y

        groundNormalX = normalX
        groundNormalY = normalY

        return fraction
      end)

    local legIds = self.engine:findDescendantComponents(id, "leg")
    local legCount = #legIds

    for _, legId in ipairs(legIds) do
      local x1, y1, x2, y2 = distanceJoints[legId]:getAnchors()

      local oldLength = heart.math.distance2(x1, y1, x2, y2)
      local newLength = heart.math.distance2(x1, y1, x2 + dx, y2 + dy)

      local length = distanceJoints[legId]:getLength()
      length = length + newLength - oldLength
      length = math.max(length, 0.75)

      if length < 2 then
        distanceJoints[legId]:setLength(length)
        bodies[id]:setAwake(true)
      elseif legCount > 4 then
        self.engine:destroyEntity(legId)
        legCount = legCount - 1
      else
        distanceJoints[legId]:setLength(2)
        bodies[id]:setAwake(true)
      end
    end

    local legIds = self.engine:findDescendantComponents(id, "leg")

    if groundFixture and legCount < 8 then
      local bodyId1 = groundFixture:getBody():getUserData()

      x1, y1 = transform:inverseTransformPoint(groundX, groundY)
      local length = math.sqrt(x1 * x1 + y1 * y1)

      local legId = self.engine:createEntity(id, {
        components = {
          leg = {},
          transform = {},

          distanceJoint = {
            body1 = bodyId1,
            body2 = id,

            x1 = x1,
            y1 = y1,

            x2 = 0,
            y2 = 0,

            collideConnected = true,
            length = length,
            frequency = 10,
            dampingRatio = 1,
          },
        },
      })
    end
  end
end

return M
