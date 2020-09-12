local class = require("heart.class")
local heartMath = require("heart.math")

local normalizeAngle = heartMath.normalizeAngle

local M = class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.physicsDomain = assert(self.engine.domains.physics)
  self.transformComponents = assert(self.engine.componentManagers.transform)
end

function M:handleEvent(dt)
  for id, body in pairs(self.physicsDomain.bodies) do
    if body:getType() == "kinematic" then
      local x1, y1 = body:getPosition()
      local angle1 = body:getAngle()

      local x2, y2, angle2 = self.transformComponents:getTransform(id):getTransform2()

      local linearVelocityX = (x2 - x1) / dt
      local linearVelocityY = (y2 - y1) / dt

      local angularVelocity = normalizeAngle(angle2 - angle1) / dt

      body:setLinearVelocity(linearVelocityX, linearVelocityY)
      body:setAngularVelocity(angularVelocity)
    end
  end
end

return M
