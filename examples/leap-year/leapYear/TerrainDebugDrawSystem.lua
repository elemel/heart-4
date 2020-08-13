local M = heart.class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.terrainComponents = assert(self.engine.componentManagers.terrain)
end

function M:handleEvent(viewportId)
  for id, tileGrid in pairs(self.terrainComponents.tileGrids) do
    for y, row in pairs(tileGrid) do
      for x in pairs(row) do
        love.graphics.rectangle("line", x, y, 1, 1)
      end
    end
  end
end

return M
