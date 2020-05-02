local class = require("heart.class")
local heartTable = require("heart.table")

local M = class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.meshInstanceManager = assert(self.game.componentManagers.meshInstance)
end

function M:drawWorld(viewportId)
  love.graphics.setDepthMode("lequal", true)
  local transforms = self.meshInstanceManager.transforms

  for id, mesh in pairs(self.meshInstanceManager.meshes) do
    love.graphics.draw(mesh, transforms[id])
  end

  love.graphics.setDepthMode()
end

return M
