local class = require("heart.class")
local heartMath = require("heart.math")

local M = class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.physicsDomain = assert(self.engine.domains.physics)
  self.transformComponents = assert(self.engine.componentManagers.transform)
end

function M:createComponent(entityId, config)
  local transform = self.transformComponents:getTransform(entityId)
  local x, y = transform:transformPoint(config.x or 0, config.y or 0)

  local _, _, angle = transform:getTransform2()
  angle = angle + (config.angle or 0)

  local bodyType = config.bodyType or "static"
  local body = love.physics.newBody(self.physicsDomain.world, x, y, bodyType)
  body:setUserData(entityId)
  body:setAngle(angle)
  local linearVelocityX = config.linearVelocityX or 0
  local linearVelocityY = config.linearVelocityY or 0
  body:setLinearVelocity(linearVelocityX, linearVelocityY)
  body:setAngularVelocity(config.angularVelocity or 0)
  body:setFixedRotation(config.fixedRotation or false)
  body:setGravityScale(config.gravityScale or 1)
  body:setSleepingAllowed(config.sleepingAllowed ~= false)
  self.physicsDomain.bodies[entityId] = body
  return body
end

function M:destroyComponent(entityId)
  self.physicsDomain.bodies[entityId]:destroy()
  self.physicsDomain.bodies[entityId] = nil
end

return M
