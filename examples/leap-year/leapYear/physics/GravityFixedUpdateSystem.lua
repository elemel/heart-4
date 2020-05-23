local GravityFixedUpdateSystem = heart.class.newClass()

function GravityFixedUpdateSystem:init(game, config)
  self.game = assert(game)
  self.gravityEntities = assert(self.game.componentEntitySets.gravity)

  self.gravityComponents = assert(self.game.componentManagers.gravity)
  self.positionComponents = assert(self.game.componentManagers.position)
end

function GravityFixedUpdateSystem:handleEvent(dt)
  local gravityXs = self.gravityComponents.gravityXs
  local gravityYs = self.gravityComponents.gravityYs

  local xs = self.positionComponents.xs
  local ys = self.positionComponents.ys

  for id in pairs(self.gravityEntities) do
    xs[id] = xs[id] + gravityXs[id] * dt * dt
    ys[id] = ys[id] + gravityYs[id] * dt * dt
  end
end

return GravityFixedUpdateSystem
