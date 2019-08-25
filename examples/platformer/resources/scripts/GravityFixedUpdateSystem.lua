local GravityFixedUpdateSystem = heart.class.newClass()

function GravityFixedUpdateSystem:init(game, config)
  self.game = assert(game)

  self.gravityX = config.gravityX or 0
  self.gravityY = config.gravityY or 0

  self.gravityEntities = assert(self.game.componentEntitySets.gravity)
  self.positionComponents = assert(self.game.componentManagers.position)
end

function GravityFixedUpdateSystem:fixedUpdate(dt)
  local gravityX = self.gravityX
  local gravityY = self.gravityY

  local xs = self.positionComponents.xs
  local ys = self.positionComponents.ys

  for id in pairs(self.gravityEntities) do
    xs[id] = xs[id] + gravityX * dt * dt
    ys[id] = ys[id] + gravityY * dt * dt
  end
end

return GravityFixedUpdateSystem
