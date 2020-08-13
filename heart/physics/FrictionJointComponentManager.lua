local class = require("heart.class")

local M = class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.physicsDomain = assert(self.engine.domains.physics)
  self.transformComponents = assert(self.engine.componentManagers.transform)
end

function M:createComponent(id, config)
  local transform = self.transformComponents.transforms[entityId]

  local bodyId2 = self.engine:findAncestorComponent(id, "body")
  local bodyId1 = self.engine:findAncestorComponent(bodyId2, "body", 1)

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

function M:destroyComponent(id)
  self.physicsDomain.frictionJoints[id]:destroy()
  self.physicsDomain.frictionJoints[id] = nil
end

return M
