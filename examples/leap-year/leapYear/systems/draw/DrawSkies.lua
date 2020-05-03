local class = require("heart.class")

local M = class.newClass()

function M:init(game, config)
  self.game = assert(game)

  self.skyEntities = assert(self.game.componentEntitySets.sky)
  self.skyManager = assert(self.game.componentManagers.sky)
end

function M:__call()
  local width, height = love.graphics.getDimensions()
  local meshes = self.skyManager.meshes

  for id in pairs(self.skyEntities) do
    love.graphics.draw(meshes[id], 0, 0, 0, width, height)
  end
end

return M
