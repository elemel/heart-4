local M = heart.class.newClass()

function M:init(game, config)
  self.game = assert(game)

  self.colliderEntities = assert(self.game.componentEntitySets.collider)
  self.colliderManager = assert(self.game.componentManagers.collider)
end

function M:fixedupdate(dt)
  for id in pairs(self.colliderEntities) do
    self.colliderManager:updateCells(id)
  end
end

return M
