local M = heart.class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.arrayImageDomain = assert(self.game.domains.arrayImage)
  self.terrainManager = assert(self.game.componentManagers.terrain)
end

function M:__call(viewportId)
  local image = self.arrayImageDomain.image
  local layerIndices = self.arrayImageDomain.layerIndices
  local scale = 1 / 16

  for id, tileGrid in pairs(self.terrainManager.tileGrids) do
    for y, row in pairs(tileGrid) do
      for x, tileType in pairs(row) do
        local layerIndex = layerIndices[tileType]
        love.graphics.drawLayer(image, layerIndex, x - 1, y - 1, 0, scale)
      end
    end
  end
end

return M
