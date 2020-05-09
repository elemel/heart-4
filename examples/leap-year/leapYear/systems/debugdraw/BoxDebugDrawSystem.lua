local M = heart.class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.boxEntities = assert(self.game.componentEntitySets.box)

  self.positionManager = assert(self.game.componentManagers.position)
  self.boxManager = assert(self.game.componentManagers.box)
end

function M:__call(viewportId)
  local xs = self.positionManager.xs
  local ys = self.positionManager.ys

  local widths = self.boxManager.widths
  local heights = self.boxManager.heights

  for id in pairs(self.boxEntities) do
    local x = xs[id]
    local y = ys[id]

    local width = widths[id]
    local height = heights[id]

    love.graphics.rectangle("line", x - 0.5 * width, y - 0.5 * height, width, height)
  end
end

return M
