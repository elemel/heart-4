local class = require("heart.class")
local heartMath = require("heart.math")

local M = class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.physicsDomain = assert(self.engine.domains.physics)
  self.transformComponents = assert(self.engine.componentManagers.transform)
end

function M:createComponent(entityId, config)
  local transform = self.transformComponents.transforms[entityId]

  local bodyId2 = self.engine:findAncestorComponent(entityId, "body")
  local bodyId1 = self.engine:findAncestorComponent(bodyId2, "body", 1)
  local body1 = self.physicsDomain.bodies[bodyId1]
  local body2 = self.physicsDomain.bodies[bodyId2]

  local x1 = config.x1 or 0
  local y1 = config.y1 or 0
  x1, y1 = transform:transformPoint(x1, y1)

  local x2 = config.x2 or 0
  local y2 = config.y2 or 0
  x2, y2 = transform:transformPoint(x2, y2)

  local axisX = config.axisX or 0
  local axisY = config.axisY or -1
  axisX, axisY = heartMath.transformVector2(transform, axisX, axisY)
  axisX, axisY = heartMath.normalize2(axisX, axisY)
  axisX, axisY = body1:getLocalVector(axisX, axisY)

  local collideConnected = config.collideConnected == true

  local joint =
    love.physics.newWheelJoint(
      body1, body2, x1, y1, x2, y2, axisX, axisY, collideConnected)

  joint:setUserData(entityId)
  joint:setMaxMotorTorque(config.maxMotorTorque or 0)
  joint:setMotorEnabled(config.motorEnabled == true)
  joint:setMotorSpeed(config.motorSpeed or 0)
  joint:setSpringDampingRatio(config.springDampingRatio or 0.7)
  joint:setSpringFrequency(config.springFrequency or 2)

  self.physicsDomain.wheelJoints[entityId] = joint
  return joint
end

function M:destroyComponent(entityId)
  self.physicsDomain.wheelJoints[entityId]:destroy()
  self.physicsDomain.wheelJoints[entityId] = nil
end

return M
