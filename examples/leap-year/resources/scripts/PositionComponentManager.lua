local PositionComponentManager = heart.class.newClass()

function PositionComponentManager:init(game, config)
  self.game = assert(game)
  self.transformComponents = assert(self.game.componentManagers.transform)
  self.xs = {}
  self.ys = {}
end

function PositionComponentManager:createComponent(id, config)
  local x = config.x or 0
  local y = config.y or 0

  local transform = self.transformComponents.transforms[id]

  if transform then
    x, y = transform:transformPoint(x, y)
  end

  self.xs[id] = x
  self.ys[id] = y
end

function PositionComponentManager:destroyComponent(id)
  self.xs[id] = nil
  self.ys[id] = nil
end

return PositionComponentManager
