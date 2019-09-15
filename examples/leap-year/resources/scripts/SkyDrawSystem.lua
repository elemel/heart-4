local class = require("heart.class")

local SkyDrawSystem = class.newClass()

function SkyDrawSystem:init(game, config)
  self.game = assert(game)

  self.skyEntities = assert(self.game.componentEntitySets.sky)
  self.skyComponents = assert(self.game.componentManagers.sky)
end

function SkyDrawSystem:draw()
  local width, height = love.graphics.getDimensions()
  local meshes = self.skyComponents.meshes

  for id in pairs(self.skyEntities) do
    love.graphics.draw(meshes[id], 0, 0, 0, width, height)
  end
end

return SkyDrawSystem
