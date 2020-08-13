local class = require("heart.class")
local heartTable = require("heart.table")

local M = class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.spriteEntities = assert(self.engine.componentEntitySets.sprite)
  self.spriteComponents = assert(self.engine.componentManagers.sprite)
  self.color = config.color or {1, 0, 0, 0.25}
end

function M:handleEvent(viewportId)
  local r, g, b, a = love.graphics.getColor()
  love.graphics.setColor(self.color)

  local transforms = self.spriteComponents.transforms
  local images = self.spriteComponents.images

  for id in pairs(self.spriteEntities) do
    local width, height = images[id]:getDimensions()

    local x1, y1 = transforms[id]:transformPoint(0, 0)
    local x2, y2 = transforms[id]:transformPoint(width, 0)
    local x3, y3 = transforms[id]:transformPoint(width, height)
    local x4, y4 = transforms[id]:transformPoint(0, height)

    love.graphics.polygon("fill", x1, y1, x2, y2, x3, y3, x4, y4)
  end

  love.graphics.setColor(r, g, b, a)
end

return M
