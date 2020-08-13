local M = heart.class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)

  self.colliderEntities = assert(self.engine.componentEntitySets.collider)
  self.colliderComponents = assert(self.engine.componentManagers.collider)
end

function M:handleEvent(dt)
  for id in pairs(self.colliderEntities) do
    self.colliderComponents:updateCells(id)
  end
end

return M
