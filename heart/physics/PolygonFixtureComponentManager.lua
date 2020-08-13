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
  local transform = self.transformComponents.transforms[entityId]

  local bodyId = assert(self.engine:findAncestorComponent(id, "body"))
  local body = self.physicsDomain.bodies[bodyId]
  local localVertices

  if config.localVertices then
    localVertices = config.localVertices
  else
    local vertices = transformPoints2(transform, config.vertices)
    localVertices = getLocalPoints(body, vertices)
  end

  local shape = love.physics.newPolygonShape(localVertices)
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
