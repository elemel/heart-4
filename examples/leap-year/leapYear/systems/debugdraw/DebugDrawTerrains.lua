local M = heart.class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.terrainManager = assert(self.game.componentManagers.terrain)
end

function M:__call(viewportId)
  for id, tileGrid in pairs(self.terrainManager.tileGrids) do
    for y, row in pairs(tileGrid) do
      for x in pairs(row) do
        love.graphics.rectangle("line", x, y, 1, 1)
      end
    end
  end
end

return M
