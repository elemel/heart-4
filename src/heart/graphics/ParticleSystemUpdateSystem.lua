local class = require("heart.class")

local ParticleSystemUpdateSystem = class.newClass()

function ParticleSystemUpdateSystem:init(game, config)
  self.game = assert(game)

  self.particleSystemComponents =
    assert(self.game.componentManagers.particleSystem)
end

function ParticleSystemUpdateSystem:update(dt)
  local particleSystems = self.particleSystemComponents.particleSystems

  for entityId, particleSystem in pairs(particleSystems) do
    particleSystem:update(dt)
  end
end

return ParticleSystemUpdateSystem
