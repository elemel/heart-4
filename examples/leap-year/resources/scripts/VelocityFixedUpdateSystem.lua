local VelocityFixedUpdateSystem = heart.class.newClass()

function VelocityFixedUpdateSystem:init(game, config)
  self.game = assert(game)
  self.velocityEntities = assert(self.game.componentEntitySets.velocity)

  self.positionComponents = assert(self.game.componentManagers.position)
  self.velocityComponents = assert(self.game.componentManagers.velocity)
end

function VelocityFixedUpdateSystem:fixedUpdate(dt)
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

return VelocityFixedUpdateSystem
