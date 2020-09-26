local heart = require("heart")

local M = heart.class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
end

function M:handleEvent(dt)
  local epsilon = 0.01
  local world = self.engine.domains.physics.world
  local bodies = self.engine.domains.physics.bodies
  local distanceJoints = self.engine.domains.physics.distanceJoints
  local transformComponents = self.engine.componentManagers.transform
  local spiderEntities = self.engine.componentEntitySets.spider
  local spiderComponents = self.engine.componentManagers.spider

  local moveInputs = spiderComponents.moveInputs
  local jumpInputs = spiderComponents.jumpInputs

  local legComponents = self.engine.componentManagers.leg
  local localJointNormals = legComponents.localJointNormals

  for spiderId in pairs(spiderEntities) do
    local spiderBody = bodies[spiderId]

    local dx = 10 * moveInputs[spiderId][1] * dt
    local dy = 10 * moveInputs[spiderId][2] * dt

    local legIds = self.engine:findDescendantComponents(spiderId, "leg")
    local jointCount = 0
    local maxLength = 2

    for i, legId in ipairs(legIds) do
      if distanceJoints[legId] then
        jointCount = jointCount + 1
      end
    end

    if jumpInputs[spiderId] and jointCount >= 1 then
      local threadBodyId = nil

      local threadAnchorX = 0
      local threadAnchorY = 0

      local jumpDirectionX = 0
      local jumpDirectionY = 0

      for i, legId in ipairs(legIds) do
        if distanceJoints[legId] then
          local body1, body2 = distanceJoints[legId]:getBodies()
          local anchorX1, anchorY1, anchorX2, anchorY2 = distanceJoints[legId]:getAnchors()

          threadBodyId = body2:getUserData()

          threadAnchorX = anchorX2
          threadAnchorY = anchorY2

          local localNormal = localJointNormals[legId]
          jumpDirectionX, jumpDirectionY = body2:getWorldVector(localNormal[1], localNormal[2])

          self.engine:destroyComponent(legId, "distanceJoint")
          jointCount = jointCount - 1
        end
      end

      local spiderTransform = transformComponents:getTransform(spiderId)
      threadAnchorX, threadAnchorY = spiderTransform:inverseTransformPoint(threadAnchorX, threadAnchorY)

      spiderBody:applyLinearImpulse(16 * jumpDirectionX, 16 * jumpDirectionY - 16)

      self.engine:createComponent(spiderId, "ropeJoint", {
        body1 = spiderId,
        body2 = threadBodyId,

        x1 = 0,
        y1 = 0.75 + 0.375,

        x2 = threadAnchorX,
        y2 = threadAnchorY,

        collideConnected = true,
        maxLength = 8,
      })
    end

    for _, legId in ipairs(legIds) do
      if distanceJoints[legId] then
        local x1, y1, x2, y2 = distanceJoints[legId]:getAnchors()
        local _, oldTargetBody = distanceJoints[legId]:getBodies()

        local directionX, directionY = heart.math.normalize2(x2 - x1, y2 - y1)

        local rayX2 = x1 + maxLength * directionX
        local rayY2 = y1 + maxLength * directionY

        local targetFixture = nil
        local targetX = 0
        local targetY = 0
        local targetNormalX = 0
        local targetNormalY = 0

        world:rayCast(
          x1, y1, rayX2, rayY2,

          function(fixture, x, y, normalX, normalY, fraction)
            if fixture:getBody() == spiderBody then
              return 1
            end

            targetFixture = fixture

            targetX = x
            targetY = y

            targetNormalX = normalX
            targetNormalY = normalY

            return fraction
          end)

        if not targetFixture or targetFixture:getBody() ~= oldTargetBody or heart.math.squaredDistance2(targetX, targetY, x2, y2) > epsilon * epsilon then
          if jointCount > 4 then
            self.engine:destroyComponent(legId, "distanceJoint")
            jointCount = jointCount - 1
          end
        end
      end

      if not jumpInputs[spiderId] and not distanceJoints[legId] then
        local legTransform = transformComponents:getTransform(legId)
        local x1, y1 = legTransform:getPosition()

        local angle = 2 * math.pi * love.math.random()

        local x2 = x1 + maxLength * math.cos(angle)
        local y2 = y1 + maxLength * math.sin(angle)

        local targetFixture = nil
        local targetX = 0
        local targetY = 0
        local targetNormalX = 0
        local targetNormalY = 0

        world:rayCast(
          x1, y1, x2, y2,

          function(fixture, x, y, normalX, normalY, fraction)
            if fixture:isSensor() or fixture:getBody() == spiderBody then
              return 1
            end

            targetFixture = fixture

            targetX = x
            targetY = y

            targetNormalX = normalX
            targetNormalY = normalY

            return fraction
          end)

        if targetFixture then
          local targetBody = targetFixture:getBody()
          local targetBodyId = targetBody:getUserData()
          local x2, y2 = legTransform:inverseTransformPoint(targetX, targetY)

          self.engine:createComponent(legId, "distanceJoint", {
            body1 = spiderId,
            body2 = targetBodyId,

            x1 = 0,
            y1 = 0,

            x2 = x2,
            y2 = y2,

            collideConnected = true,
            frequency = 10,
            dampingRatio = 1,
          })

          jointCount = jointCount + 1
          local localNormal = localJointNormals[legId]
          localNormal[1], localNormal[2] = targetBody:getLocalVector(targetNormalX, targetNormalY)

          self.engine:destroyComponent(spiderId, "ropeJoint")
        end
      end
    end

    for _, legId in ipairs(legIds) do
      if distanceJoints[legId] then
        local x1, y1, x2, y2 = distanceJoints[legId]:getAnchors()

        local oldLength = heart.math.distance2(x1, y1, x2, y2)
        local newLength = heart.math.distance2(x1 + dx, y1 + dy, x2, y2)
        local length = distanceJoints[legId]:getLength()

        length = length + newLength - oldLength
        length = math.max(length, 0.25)

        if length < maxLength then
          distanceJoints[legId]:setLength(length)
          bodies[spiderId]:setAwake(true)
        elseif jointCount > 4 then
          self.engine:destroyComponent(legId, "distanceJoint")
          jointCount = jointCount - 1
        else
          distanceJoints[legId]:setLength(maxLength)
          bodies[spiderId]:setAwake(true)
        end
      end
    end
  end
end

return M
