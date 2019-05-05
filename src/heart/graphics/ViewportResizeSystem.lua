local class = require("heart.class")

local ViewportResizeSystem = class.newClass()

function ViewportResizeSystem:init(game, config)
  self.game = assert(game)
  self.bones = assert(self.game.componentManagers.bone)
  self.viewportEntities = assert(self.game.componentEntitySets.viewport)
  self.viewportComponents = assert(self.game.componentManagers.viewport)
end

function ViewportResizeSystem:resize(width, height)
  local widths = self.viewportComponents.widths
  local heights = self.viewportComponents.heights

  for entityId in pairs(self.viewportEntities) do
    widths[entityId] = width
    heights[entityId] = height
  end
end

return ViewportResizeSystem
