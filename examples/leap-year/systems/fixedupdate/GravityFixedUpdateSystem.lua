local GravityFixedUpdateSystem = heart.class.newClass()

function GravityFixedUpdateSystem:init(game, config)
  self.game = assert(game)

  self.gravityEntities = assert(self.game.componentEntitySets.gravity)
  self.gravityManager = assert(self.game.componentManagers.gravity)

  self.positionManager = assert(self.game.componentManagers.position)
end

function GravityFixedUpdateSystem:__call(dt)
  local gravityXs = self.gravityManager.gravityXs
  local gravityYs = self.gravityManager.gravityYs

  local xs = self.positionManager.xs
  local ys = self.positionManager.ys

  for id in pairs(self.gravityEntities) do
    xs[id] = xs[id] + gravityXs[id] * dt * dt
    ys[id] = ys[id] + gravityYs[id] * dt * dt
  end
end

return GravityFixedUpdateSystem
