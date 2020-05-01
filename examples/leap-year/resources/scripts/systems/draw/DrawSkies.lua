local class = require("heart.class")

local M = class.newClass()

function M:init(game, config)
  self.game = assert(game)

  self.skyEntities = assert(self.game.componentEntitySets.sky)
  self.skyComponents = assert(self.game.componentManagers.sky)
end

function M:draw()
  local width, height = love.graphics.getDimensions()
  local meshes = self.skyComponents.meshes

  for id in pairs(self.skyEntities) do
    love.graphics.draw(meshes[id], 0, 0, 0, width, height)
  end
end

return M
