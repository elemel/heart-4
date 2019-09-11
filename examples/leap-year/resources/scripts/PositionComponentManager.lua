local PositionComponentManager = heart.class.newClass()

function PositionComponentManager:init(game, config)
  self.xs = {}
  self.ys = {}
end

function PositionComponentManager:createComponent(id, config, transform)
  local x = config.x or 0
  local y = config.y or 0

  x, y = transform:transformPoint(x, y)

  self.xs[id] = x
  self.ys[id] = y
end

function PositionComponentManager:destroyComponent(id)
  self.xs[id] = nil
  self.ys[id] = nil
end

return PositionComponentManager
