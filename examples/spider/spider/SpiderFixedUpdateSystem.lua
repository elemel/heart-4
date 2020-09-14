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
  local legComponents = self.engine.componentManagers.leg
  local targets = legComponents.targets

  for id in pairs(spiderEntities) do
    local dx = 10 * moveInputs[id][1] * dt
    local dy = 10 * moveInputs[id][2] * dt

    local legIds = self.engine:findDescendantComponents(id, "leg")
    local jointCount = 0

    for _, legId in ipairs(legIds) do
      if distanceJoints[legId] then
        jointCount = jointCount + 1
      end
    end

    for _, legId in ipairs(legIds) do
      if distanceJoints[legId] then
        local x1, y1, x2, y2 = distanceJoints[legId]:getAnchors()

        local oldLength = heart.math.distance2(x1, y1, x2, y2)
        local newLength = heart.math.distance2(x1, y1, x2 + dx, y2 + dy)

        local length = distanceJoints[legId]:getLength()
        length = length + newLength - oldLength
        length = math.max(length, 0.75)

        if length < 2 then
          distanceJoints[legId]:setLength(length)
          bodies[id]:setAwake(true)
        elseif jointCount > 4 then
          self.engine:destroyComponent(legId, "distanceJoint")
          jointCount = jointCount - 1
        else
          distanceJoints[legId]:setLength(2)
          bodies[id]:setAwake(true)
        end
      end
    end

    for _, legId in ipairs(legIds) do
      if not distanceJoints[legId] and targets[legId][1] then
        local transform = transformComponents:getTransform(legId)
        local bodyId1 = targets[legId][1]:getBody():getUserData()

        local x1, y1 = transform:inverseTransformPoint(targets[legId][2], targets[legId][3])
        local length = math.sqrt(x1 * x1 + y1 * y1)

        self.engine:createComponent(legId, "distanceJoint", {
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
        })
      end
    end
  end
end

return M
