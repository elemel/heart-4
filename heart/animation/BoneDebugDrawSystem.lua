local class = require("heart.class")

local M = class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.color = config.color or {0, 1, 0, 1}
  self.scale = config.scale or 1

  self.boneEntities = assert(self.game.componentEntitySets.bone)
  self.transformComponents = assert(self.game.componentManagers.transform)
end

function M:__call(viewportId)
  local r, g, b, a = love.graphics.getColor()
  love.graphics.setColor(self.color)

  local entityParents = self.game.entityParents
  local transforms = self.transformComponents.transforms

  for id in pairs(self.boneEntities) do
    local transform = transforms[id]
    local x1, y1 = transform:transformPoint(self.scale, 0)
    local x2, y2 = transform:transformPoint(0, 0)
    local x3, y3 = transform:transformPoint(0, self.scale)
    love.graphics.line(x1, y1, x2, y2, x3, y3)
  end

  love.graphics.setColor(r, g, b, a)
end

return M
