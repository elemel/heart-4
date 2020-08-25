local class = require("heart.class")

local M = class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.viewportEntities = assert(self.engine.componentEntitySets.viewport)
  self.viewportComponents = assert(self.engine.componentManagers.viewport)
end

function M:handleEvent(width, height)
  local sizes = self.viewportComponents.sizes

  for id in pairs(self.viewportEntities) do
    sizes[id] = {width, height}
  end
end

return M
