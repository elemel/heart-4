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

  local bodyId = assert(self.engine:findAncestorComponent(entityId, "body"))
  local body = self.physicsDomain.bodies[bodyId]
  local x = config.x or 0
  local y = config.y or 0
  local width = config.width or 1
  local height = config.height or 1
  local angle = config.angle or 0

  local x1, y1, x2, y2, x3, y3, x4, y4 =
    heartMath.rectangleVertices(x, y, width, height, angle)

  x1, y1 = body:getLocalPoint(transform:transformPoint(x1, y1))
  x2, y2 = body:getLocalPoint(transform:transformPoint(x2, y2))
  x3, y3 = body:getLocalPoint(transform:transformPoint(x3, y3))
  x4, y4 = body:getLocalPoint(transform:transformPoint(x4, y4))
  local shape = love.physics.newPolygonShape(x1, y1, x2, y2, x3, y3, x4, y4)
  local density = config.density or 1
  local fixture = love.physics.newFixture(body, shape, density)
  fixture:setUserData(entityId)
  fixture:setFriction(config.friction or 0.2)
  fixture:setRestitution(config.restitution or 0)
  fixture:setGroupIndex(config.groupIndex or 0)
  fixture:setSensor(config.sensor or false)
  self.physicsDomain.rectangleFixtures[entityId] = fixture
  return fixture
end

function M:destroyComponent(entityId)
  self.physicsDomain.rectangleFixtures[entityId]:destroy()
  self.physicsDomain.rectangleFixtures[entityId] = nil
end

return M
