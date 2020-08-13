local class = require("heart.class")

local M = class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.color = config.color or {0, 1, 0, 1}

  self.parentConstraintEntities =
    assert(self.engine.componentEntitySets.parentConstraint)

  self.transformComponents = assert(self.engine.componentManagers.transform)
end

function M:handleEvent(viewportId)
  local r, g, b, a = love.graphics.getColor()
  love.graphics.setColor(self.color)

  local entityParents = self.engine.entityParents
  local transforms = self.transformComponents.transforms

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
