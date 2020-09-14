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
  local spiderComponents = self.engine.componentManagers.spider
  local moveInputs = spiderComponents.moveInputs
  local eyeComponents = self.engine.componentManagers.eye
  local targets = eyeComponents.targets

  for id in pairs(spiderEntities) do
    local dx = 10 * moveInputs[id][1] * dt
    local dy = 10 * moveInputs[id][2] * dt

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

    local eyeIds = self.engine:findDescendantComponents(id, "eye")
    local transform = transformComponents:getTransform(id)

    for _, eyeId in ipairs(eyeIds) do
      if targets[eyeId][1] and legCount < 8 then
        local bodyId1 = targets[eyeId][1]:getBody():getUserData()

        local x1, y1 = transform:inverseTransformPoint(targets[eyeId][2], targets[eyeId][3])
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
end

return M
