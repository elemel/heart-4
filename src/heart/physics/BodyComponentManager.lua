local class = require("heart.class")
local heartMath = require("heart.math")

local BodyComponentManager = class.newClass()

function BodyComponentManager:init(game, config)
  self.game = assert(game)
  self.physicsDomain = assert(self.game.domains.physics)
end

function BodyComponentManager:createComponent(entityId, config, transform)
  local x = config.x or 0
  local y = config.y or 0
  x, y = transform:transformPoint(x, y)
  local angle = config.angle or 0
  angle = heartMath.transformAngle(transform, angle)
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

function BodyComponentManager:destroyComponent(entityId)
  self.physicsDomain.bodies[entityId]:destroy()
  self.physicsDomain.bodies[entityId] = nil
end

return BodyComponentManager
