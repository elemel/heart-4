local class = require("heart.class")

local M = class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.color = config.color or {0, 1, 0, 1}
  self.scale = config.scale or 1

  self.boneEntities = assert(self.engine.componentEntitySets.bone)
  self.transformComponents = assert(self.engine.componentManagers.transform)
end

function M:handleEvent(viewportId)
  local r, g, b, a = love.graphics.getColor()
  love.graphics.setColor(self.color)

  local entityParents = self.engine.entityParents
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
