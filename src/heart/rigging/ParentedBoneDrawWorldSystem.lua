local class = require("heart.class")
local mathUtils = require("heart.math.utils")

local ParentedBoneDrawWorldSystem = class.newClass()

function ParentedBoneDrawWorldSystem:init(game, config)
  self.game = assert(game)
  self.color = config.color or {0, 1, 0, 1}
  self.bones = assert(self.game.componentManagers.bone)

  self.parentedBoneEntities =
    assert(self.game.componentEntitySets.parentedBone)
end

function ParentedBoneDrawWorldSystem:drawWorld(viewportId)
  local r, g, b, a = love.graphics.getColor()
  love.graphics.setColor(self.color)

  local entityParents = self.game.entityParents
  local transforms = self.bones.transforms

  for entityId in pairs(self.parentedBoneEntities) do
    local transform = transforms[entityId]
    local parentId = entityParents[entityId]
    local parentTransform = transforms[parentId]
    local x1, y1 = parentTransform:transformPoint(0, 0)
    local x2, y2 = transform:transformPoint(0, 0)
    love.graphics.line(x1, y1, x2, y2)
  end

  love.graphics.setColor(r, g, b, a)
end

return ParentedBoneDrawWorldSystem
