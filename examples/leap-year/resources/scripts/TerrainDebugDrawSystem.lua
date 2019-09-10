local TerrainDebugDrawSystem = heart.class.newClass()

function TerrainDebugDrawSystem:init(game, config)
  self.game = assert(game)
  self.terrainComponents = assert(self.game.componentManagers.terrain)
end

function TerrainDebugDrawSystem:debugDraw(viewportId)
  for id, tileGrid in pairs(self.terrainComponents.tileGrids) do
    for y, row in pairs(tileGrid) do
      for x in pairs(row) do
        love.graphics.rectangle("line", x, y, 1, 1)
      end
    end
  end
end

return TerrainDebugDrawSystem
