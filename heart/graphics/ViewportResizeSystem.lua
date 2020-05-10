local class = require("heart.class")

local M = class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.viewportEntities = assert(self.game.componentEntitySets.viewport)
  self.viewportComponents = assert(self.game.componentManagers.viewport)
end

function M:__call(width, height)
  local widths = self.viewportComponents.widths
  local heights = self.viewportComponents.heights

  for entityId in pairs(self.viewportEntities) do
    widths[entityId] = width
    heights[entityId] = height
  end
end

return M
