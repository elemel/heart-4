local class = require("heart.class")

local M = class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.physicsDomain = assert(self.engine.domains.physics)
  self.transformComponents = assert(self.engine.componentManagers.transform)
end

function M:createComponent(entityId, config)
  local transform = self.transformComponents.transforms[entityId]
  local bodyId2 = config.body2 or "body"

  if type(bodyId2) == "string" then
    bodyId2 = self.engine:findAncestorComponent(entityId, bodyId2)
  end

  local bodyId1 = config.body1 or "body"

  if type(bodyId1) == "string" then
    bodyId1 = self.engine:findAncestorComponent(bodyId2, bodyId1, 1)
  end

  local body1 = self.physicsDomain.bodies[bodyId1]
  local body2 = self.physicsDomain.bodies[bodyId2]
  local x1 = config.x1 or 0
  local y1 = config.y1 or 0
  x1, y1 = transform:transformPoint(x1, y1)
  local x2 = config.x2 or 0
  local y2 = config.y2 or 0
  x2, y2 = transform:transformPoint(x2, y2)
  local maxLength = config.maxLength or 1
  local collideConnected = config.collideConnected == true

  local joint =
    love.physics.newRopeJoint(
      body1, body2, x1, y1, x2, y2, maxLength, collideConnected)

  joint:setUserData(entityId)
  self.physicsDomain.ropeJoints[entityId] = joint
  return joint
end

function M:destroyComponent(entityId)
  self.physicsDomain.ropeJoints[entityId]:destroy()
  self.physicsDomain.ropeJoints[entityId] = nil
end

return M
