local class = require("heart.class")

local ViewportResizeSystem = class.newClass()

function ViewportResizeSystem:init(game, config)
  self.game = assert(game)
  self.bones = assert(self.game.componentManagers.bone)
  self.viewportEntities = assert(self.game.componentEntitySets.viewport)
end

function ViewportResizeSystem:resize(width, height)
  local transforms = self.bones.transforms
  local scale = 8 / height
  local originX = 0.5 * width
  local originY = 0.5 * height

  for entityId in pairs(self.viewportEntities) do
    local transform = transforms[entityId]
    transform:setTransformation(0, 0, 0, scale, scale, originX, originY)
  end
end

return ViewportResizeSystem
