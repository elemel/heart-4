local class = require("heart.class")
local heartTable = require("heart.table")

local M = class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.spriteEntities = assert(self.engine.componentEntitySets.sprite)
  self.spriteComponents = assert(self.engine.componentManagers.sprite)
end

function M:handleEvent(viewportId)
  local transforms = self.spriteComponents.transforms
  local ids = heartTable.keys(self.spriteEntities)
  local zs = self.spriteComponents.zs
  table.sort(ids, function(a, b) return zs[a] < zs[b] end)
  local images = self.spriteComponents.images

  for _, id in ipairs(ids) do
    love.graphics.draw(images[id], transforms[id])
  end
end

return M
