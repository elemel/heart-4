local class = require("heart.class")

local M = class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.viewportEntities = assert(self.engine.componentEntitySets.viewport)
  self.viewportComponents = assert(self.engine.componentManagers.viewport)
end

function M:handleEvent(width, height)
  local widths = self.viewportComponents.widths
  local heights = self.viewportComponents.heights

  for entityId in pairs(self.viewportEntities) do
    widths[entityId] = width
    heights[entityId] = height
  end
end

return M
