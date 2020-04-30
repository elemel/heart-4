local class = require("heart.class")

local M = class.newClass()

function M:init(game, config)
  self.game = assert(game)

  self.particleSystemComponents =
    assert(self.game.componentManagers.particleSystem)
end

function M:update(dt)
  local particleSystems = self.particleSystemComponents.particleSystems

  for entityId, particleSystem in pairs(particleSystems) do
    particleSystem:update(dt)
  end
end

return M
