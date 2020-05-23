local M = heart.class.newClass()

function M:init(game, config)
  self.game = assert(game)

  self.colliderEntities = assert(self.game.componentEntitySets.collider)
  self.colliderComponents = assert(self.game.componentManagers.collider)
end

function M:handleEvent(dt)
  for id in pairs(self.colliderEntities) do
    self.colliderComponents:updateCells(id)
  end
end

return M
