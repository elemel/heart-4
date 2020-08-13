local class = require("heart.class")

local M = class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)

  self.particleSystemComponents =
    assert(self.engine.componentManagers.particleSystem)
end

function M:handleEvent(dt)
  local particleSystems = self.particleSystemComponents.particleSystems

  for entityId, particleSystem in pairs(particleSystems) do
    particleSystem:update(dt)
  end
end

return M
