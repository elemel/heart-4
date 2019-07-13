local class = require("heart.class")

local FrictionJointComponentManager = class.newClass()

function FrictionJointComponentManager:init(game, config)
  self.game = assert(game)
  self.physicsDomain = assert(self.game.domains.physics)
end

function FrictionJointComponentManager:createComponent(id, config, transform)
  local bodyId2 = self.game:findAncestorComponent(id, "body")
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
    love.physics.newFrictionJoint(
      body1, body2, x1, y1, x2, y2, collideConnected)

  joint:setUserData(id)
  joint:setMaxForce(config.maxForce or 0)
  joint:setMaxTorque(config.maxTorque or 0)

  self.physicsDomain.frictionJoints[id] = joint
  return joint
end

function FrictionJointComponentManager:destroyComponent(id)
  self.physicsDomain.frictionJoints[id]:destroy()
  self.physicsDomain.frictionJoints[id] = nil
end

return FrictionJointComponentManager
