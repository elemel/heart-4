local M = heart.class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.positionManager = assert(self.game.componentManagers.position)

  self.previousXs = {}
  self.previousYs = {}
end

function M:createComponent(id, config)
  self.previousXs[id] = config.previousX or self.positionManager.xs[id]
  self.previousYs[id] = config.previousY or self.positionManager.ys[id]
end

function M:destroyComponent(id)
  self.previousYs[id] = nil
  self.previousXs[id] = nil
end

return M
