local class = require("heart.class")

local M = class.newClass()

function M:init(game, config)
  self.game = assert(game)

  self.particleSystemComponents =
    assert(self.game.componentManagers.particleSystem)
end

function M:drawWorld(viewportId)
  love.graphics.setDepthMode("less", false)
  local particleSystems = self.particleSystemComponents.particleSystems
  local blendModes = self.particleSystemComponents.blendModes
  local zs = self.particleSystemComponents.zs

  for entityId, particleSystem in pairs(particleSystems) do
    if zs[entityId] == -1 then
      love.graphics.setBlendMode(blendModes[entityId])
      love.graphics.draw(particleSystem)
    end
  end

  for entityId, particleSystem in pairs(particleSystems) do
    if zs[entityId] == 0 then
      love.graphics.setBlendMode(blendModes[entityId])
      love.graphics.draw(particleSystem)
    end
  end

  love.graphics.setBlendMode("alpha")
  love.graphics.setDepthMode()
end

return M
