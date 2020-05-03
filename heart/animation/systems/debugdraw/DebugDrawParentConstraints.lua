local class = require("heart.class")

local M = class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.color = config.color or {0, 1, 0, 1}
  self.boneManager = assert(self.game.componentManagers.bone)

  self.parentConstraintEntities =
    assert(self.game.componentEntitySets.parentConstraint)
end

function M:__call(viewportId)
  local r, g, b, a = love.graphics.getColor()
  love.graphics.setColor(self.color)

  local entityParents = self.game.entityParents
  local transforms = self.boneManager.transforms

  for id in pairs(self.parentConstraintEntities) do
    local transform = transforms[id]
    local parentId = entityParents[id]
    local parentTransform = transforms[parentId]
    local x1, y1 = parentTransform:transformPoint(0, 0)
    local x2, y2 = transform:transformPoint(0, 0)
    love.graphics.line(x1, y1, x2, y2)
  end

  love.graphics.setColor(r, g, b, a)
end

return M
