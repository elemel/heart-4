local M = heart.class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.velocityEntities = assert(self.game.componentEntitySets.velocity)

  self.positionManager = assert(self.game.componentManagers.position)
  self.velocityManager = assert(self.game.componentManagers.velocity)
end

function M:fixedUpdate(dt)
  local xs = self.positionManager.xs
  local ys = self.positionManager.ys

  local previousXs = self.velocityManager.previousXs
  local previousYs = self.velocityManager.previousYs

  for id in pairs(self.velocityEntities) do
    local dx = xs[id] - previousXs[id]
    local dy = ys[id] - previousYs[id]

    previousXs[id] = xs[id]
    previousYs[id] = ys[id]

    xs[id] = xs[id] + dx
    ys[id] = ys[id] + dy
  end
end

return M
