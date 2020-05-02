local class = require("heart.class")
local heartTable = require("heart.table")

local M = class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.meshManager = assert(self.game.componentManagers.mesh)
end

function M:drawWorld(viewportId)
  love.graphics.setDepthMode("lequal", true)
  local transforms = self.meshManager.transforms

  for id, mesh in pairs(self.meshManager.meshes) do
    love.graphics.draw(mesh, transforms[id])
  end

  love.graphics.setDepthMode()
end

return M
