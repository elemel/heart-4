local class = require("heart.class")
local heartMath = require("heart.math")

local PolygonFixtureComponentManager = class.newClass()

function PolygonFixtureComponentManager:init(game, config)
  self.game = assert(game)
  self.physicsDomain = assert(self.game.domains.physics)
end

function PolygonFixtureComponentManager:createComponent(id, config, transform)
  local bodyId = assert(self.game:findAncestorComponent(id, "body"))
  local body = self.physicsDomain.bodies[bodyId]
  local localVertices

  if config.localVertices then
    localVertices = config.localVertices
  else
    localVertices = heart.physics.getLocalPoints(body, config.vertices)
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

function PolygonFixtureComponentManager:destroyComponent(id)
  self.physicsDomain.polygonFixtures[id]:destroy()
  self.physicsDomain.polygonFixtures[id] = nil
end

return PolygonFixtureComponentManager
