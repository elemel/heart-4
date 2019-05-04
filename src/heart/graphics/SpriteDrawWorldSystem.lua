local class = require("heart.class")
local heartTable = require("heart.table")

local SpriteDrawWorldSystem = class.newClass()

function SpriteDrawWorldSystem:init(game, config)
  self.game = assert(game)
  self.bones = assert(self.game.componentManagers.bone)
  self.sprites = assert(self.game.componentManagers.sprite)
  self.spriteEntities = assert(self.game.componentEntitySets.sprite)
end

function SpriteDrawWorldSystem:drawWorld(viewportId)
  local transforms = self.bones.transforms
  local entityIds = heartTable.keys(self.spriteEntities)
  local zs = self.sprites.zs
  table.sort(entityIds, function(a, b) return zs[a] < zs[b] end)
  local images = self.sprites.images

  for i, entityId in ipairs(entityIds) do
    local image = images[entityId]
    local transform = transforms[entityId]
    love.graphics.draw(image, transform)
  end
end

return SpriteDrawWorldSystem
