local class = require("heart.class")
local physics = require("heart.physics")
local getLocalPoints = physics.getLocalPoints
local heartMath = require("heart.math")
local transformPoints2 = heartMath.transformPoints2

local M = class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.physicsDomain = assert(self.engine.domains.physics)
  self.transformComponents = assert(self.engine.componentManagers.transform)
end

function M:createComponent(id, config)
  local entityTransform = self.transformComponents:getTransform(id)
  local bodyId = assert(self.engine:findAncestorComponent(id, "body"))
  local body = self.physicsDomain.bodies[bodyId]

  local points = config.points or {
    -0.5, -0.5,
    0.5, -0.5,
    0.5, 0.5,
    -0.5, 0.5,
  }

  local localTransform = love.math.newTransform()

  if config.transform then
    localTransform:setTransformation(unpack(config.transform))
  end

  local transform = love.math.newTransform():setMatrix(entityTransform:getMatrix()):apply(localTransform)

  points = transformPoints2(transform, points)
  points = getLocalPoints(body, points)

  local shape = love.physics.newPolygonShape(points)
  local density = config.density or 1
  local fixture = love.physics.newFixture(body, shape, density)
  fixture:setUserData(id)
  fixture:setFriction(config.friction or 0.2)
  fixture:setRestitution(config.restitution or 0)
  fixture:setGroupIndex(config.groupIndex or 0)
  fixture:setSensor(config.sensor or false)
  self.physicsDomain.polygonFixtures[id] = fixture
  return fixture
end

function M:destroyComponent(id)
  self.physicsDomain.polygonFixtures[id]:destroy()
  self.physicsDomain.polygonFixtures[id] = nil
end

return M
