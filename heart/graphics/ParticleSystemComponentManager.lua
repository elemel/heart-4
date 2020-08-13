local class = require("heart.class")

local M = class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.imageLoader = assert(engine.resourceLoaders.image)
  self.particleSystems = {}
  self.zs = {}
  self.blendModes = {}
end

function M:createComponent(entityId, config)
  local imageFilename = assert(config.image)
  local image = self.imageLoader:loadResource(imageFilename)
  local bufferSize = config.bufferSize or 1000
  local particleSystem = love.graphics.newParticleSystem(image, bufferSize)
  particleSystem:setEmissionRate(config.emissionRate or 1)

  local minParticleLifetime = config.minParticleLifetime or 1
  local maxParticleLifetime = config.maxParticleLifetime or 1
  particleSystem:setParticleLifetime(minParticleLifetime, maxParticleLifetime)

  if config.sizes then
    particleSystem:setSizes(unpack(config.sizes))
  end

  local minRotation = config.minRotation or 0
  local maxRotation = config.maxRotation or 0
  particleSystem:setRotation(minRotation, maxRotation)

  local minLinearAccelerationX = config.minLinearAccelerationX or 0
  local minLinearAccelerationY = config.minLinearAccelerationY or 0
  local maxLinearAccelerationX = config.maxLinearAccelerationX or 0
  local maxLinearAccelerationY = config.maxLinearAccelerationY or 0

  particleSystem:setLinearAcceleration(
      minLinearAccelerationX, minLinearAccelerationY,
      maxLinearAccelerationX, maxLinearAccelerationY)

  local minLinearDamping = config.minLinearDamping or 0
  local maxLinearDamping = config.maxLinearDamping or 0
  particleSystem:setLinearDamping(minLinearDamping, maxLinearDamping)

  local areaSpreadDistribution = config.areaSpreadDistribution or "none"
  local areaSpreadDistanceX = config.areaSpreadDistanceX or 0
  local areaSpreadDistanceY = config.areaSpreadDistanceY or 0

  particleSystem:setEmissionArea(
      areaSpreadDistribution, areaSpreadDistanceX, areaSpreadDistanceY)

  local minSpeed = config.minSpeed or 0
  local maxSpeed = config.maxSpeed or 0
  particleSystem:setSpeed(minSpeed, maxSpeed)

  local spread = config.spread or 0
  particleSystem:setSpread(spread)

  if config.colors then
    particleSystem:setColors(unpack(config.colors))
  end

  particleSystem:setEmitterLifetime(config.emitterLifetime or -1)

  self.particleSystems[entityId] = particleSystem
  self.blendModes[entityId] = config.blendMode or "alpha"
  self.zs[entityId] = config.z or 0
end

function M:destroyComponent(entityId)
  self.particleSystems[entityId] = nil
  self.blendModes[entityId] = nil
  self.zs[entityId] = nil
end

return M
