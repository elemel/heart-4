local class = require("heart.class")
local heartTable = require("heart.table")

local M = class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.meshInstanceComponents = assert(self.engine.componentManagers.meshInstance)
end

function M:handleEvent(viewportId)
  love.graphics.setDepthMode("lequal", true)
  local transforms = self.meshInstanceComponents.transforms

  for id, mesh in pairs(self.meshInstanceComponents.meshes) do
    love.graphics.draw(mesh, transforms[id])
  end

  love.graphics.setDepthMode()
end

return M
