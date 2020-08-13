local M = heart.class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.arrayImageDomain = assert(self.engine.domains.arrayImage)
  self.terrainComponents = assert(self.engine.componentManagers.terrain)
end

function M:handleEvent(viewportId)
  local image = self.arrayImageDomain.image
  local layerIndices = self.arrayImageDomain.layerIndices
  local scale = 1 / 16

  for id, tileGrid in pairs(self.terrainComponents.tileGrids) do
    for y, row in pairs(tileGrid) do
      for x, tileType in pairs(row) do
        local layerIndex = layerIndices[tileType]
        love.graphics.drawLayer(image, layerIndex, x - 1, y - 1, 0, scale)
      end
    end
  end
end

return M
