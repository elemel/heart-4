local class = require("heart.class")
local heartTable = require("heart.table")

local M = class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.spriteEntities = assert(self.engine.componentEntitySets.sprite)
  self.spriteComponents = assert(self.engine.componentManagers.sprite)
end

function M:handleEvent(viewportId)
  local images = self.spriteComponents.images
  local transforms = self.spriteComponents.transforms

  for id in pairs(self.spriteEntities) do
    love.graphics.draw(images[id], transforms[id])
  end
end

return M
