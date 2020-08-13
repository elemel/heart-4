local M = heart.class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.velocityEntities = assert(self.engine.componentEntitySets.velocity)

  self.positionComponents = assert(self.engine.componentManagers.position)
  self.velocityComponents = assert(self.engine.componentManagers.velocity)
end

function M:handleEvent(dt)
  local xs = self.positionComponents.xs
  local ys = self.positionComponents.ys

  local previousXs = self.velocityComponents.previousXs
  local previousYs = self.velocityComponents.previousYs

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
