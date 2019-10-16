local class = require("heart.class")
local heartMath = require("heart.math")
local physicsUtils = require("heart.physics.utils")

local ChainFixtureComponentManager = class.newClass()

function ChainFixtureComponentManager:init(game, config)
  self.game = assert(game)
  self.physicsDomain = assert(self.game.domains.physics)
  self.transformComponents = assert(self.game.componentManagers.transform)
end

function ChainFixtureComponentManager:createComponent(entityId, config)
  local transform = self.transformComponents.transforms[entityId]

  local bodyId = assert(self.game:findAncestorComponent(entityId, "body"))
  local body = self.physicsDomain.bodies[bodyId]
  local loop = config.loop == true
  local points = assert(config.points)
  local worldPoints = heartMath.transformPoints2(transform, points)
  local localPoints = physicsUtils.getLocalPoints(body, worldPoints)

  local shape = love.physics.newChainShape(loop, localPoints)
  local density = config.density or 1
  local fixture = love.physics.newFixture(body, shape, density)
  fixture:setUserData(entityId)
  fixture:setFriction(config.friction or 0.2)
  fixture:setRestitution(config.restitution or 0)
  fixture:setGroupIndex(config.groupIndex or 0)
  fixture:setSensor(config.sensor or false)
  self.physicsDomain.chainFixtures[entityId] = fixture
  return fixture
end

function ChainFixtureComponentManager:destroyComponent(entityId)
  self.physicsDomain.chainFixtures[entityId]:destroy()
  self.physicsDomain.chainFixtures[entityId] = nil
end

return ChainFixtureComponentManager
