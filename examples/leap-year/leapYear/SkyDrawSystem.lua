local class = require("heart.class")

local M = class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)

  self.skyEntities = assert(self.engine.componentEntitySets.sky)
  self.skyComponents = assert(self.engine.componentManagers.sky)
end

function M:handleEvent()
  local width, height = love.graphics.getDimensions()
  local meshes = self.skyComponents.meshes

  for id in pairs(self.skyEntities) do
    love.graphics.draw(meshes[id], 0, 0, 0, width, height)
  end
end

return M
