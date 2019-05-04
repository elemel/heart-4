local class = require("heart.class")
local mathUtils = require("heart.math.utils")

local RevoluteJointComponentManager = class.newClass()

function RevoluteJointComponentManager:init(game, config)
  self.game = assert(game)
  self.physicsDomain = assert(self.game.domains.physics)
end

function RevoluteJointComponentManager:createComponent(entityId, config, transform)
  local bodyId2 = self.game:findAncestorComponent(entityId, "body")
  local bodyId1 = self.game:findAncestorComponent(bodyId2, "body", 1)
  local body1 = self.physicsDomain.bodies[bodyId1]
  local body2 = self.physicsDomain.bodies[bodyId2]
  local x1 = config.x1 or 0
  local y1 = config.y1 or 0
  x1, y1 = transform:transformPoint(x1, y1)
  local x2 = config.x2 or 0
  local y2 = config.y2 or 0
  x2, y2 = transform:transformPoint(x2, y2)
  local collideConnected = config.collideConnected == true

  local joint =
    love.physics.newRevoluteJoint(
      body1, body2, x1, y1, x2, y2, collideConnected)

  joint:setUserData(entityId)
  joint:setMaxMotorTorque(config.maxMotorTorque or 0)
  joint:setMotorEnabled(config.motorEnabled == true)
  joint:setMotorSpeed(config.motorSpeed or 0)
  joint:setLimitsEnabled(config.limitsEnabled == true)
  local lowerLimit = config.lowerLimit or 0
  local upperLimit = config.upperLimit or 0
  joint:setLimits(lowerLimit, upperLimit)
  self.physicsDomain.revoluteJoints[entityId] = joint
  return joint
end

function RevoluteJointComponentManager:destroyComponent(entityId)
  self.physicsDomain.revoluteJoints[entityId]:destroy()
  self.physicsDomain.revoluteJoints[entityId] = nil
end

return RevoluteJointComponentManager
