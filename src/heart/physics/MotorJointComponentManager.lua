local class = require("heart.class")

local MotorJointComponentManager = class.newClass()

function MotorJointComponentManager:init(game, config)
  self.game = assert(game)
  self.physicsDomain = assert(self.game.domains.physics)
  self.transformComponents = assert(self.game.componentManagers.transform)
end

function MotorJointComponentManager:createComponent(entityId, config)
  local transform = self.transformComponents.transforms[entityId]
  local bodyId2 = config.body2 or "body"

  if type(bodyId2) == "string" then
    bodyId2 = self.game:findAncestorComponent(entityId, bodyId2)
  end

  local bodyId1 = config.body1 or "body"

  if type(bodyId1) == "string" then
    bodyId1 = self.game:findAncestorComponent(bodyId2, bodyId1, 1)
  end

  local body1 = self.physicsDomain.bodies[bodyId1]
  local body2 = self.physicsDomain.bodies[bodyId2]
  local correctionFactor = config.correctionFactor or 0.3
  local collideConnected = config.collideConnected == true

  local joint =
    love.physics.newMotorJoint(
      body1, body2, correctionFactor, collideConnected)

  joint:setUserData(entityId)
  local linearOffsetX = config.linearOffsetX or 0
  local linearOffsetY = config.linearOffsetY or 0
  joint:setLinearOffset(linearOffsetX, linearOffsetY)
  joint:setAngularOffset(config.angularOffset or 0)
  joint:setMaxForce(config.maxForce or 0)
  joint:setMaxTorque(config.maxTorque or 0)
  self.physicsDomain.motorJoints[entityId] = joint
  return joint
end

function MotorJointComponentManager:destroyComponent(entityId)
  self.physicsDomain.motorJoints[entityId]:destroy()
  self.physicsDomain.motorJoints[entityId] = nil
end

return MotorJointComponentManager
