local PositionComponentManager = heart.class.newClass()

function PositionComponentManager:init(game, config)
  self.xs = {}
  self.ys = {}
end

function PositionComponentManager:createComponent(id, config, transform)
  self.xs[id] = config.x or 0
  self.ys[id] = config.y or 0
end

function PositionComponentManager:destroyComponent(id)
  self.xs[id] = nil
  self.ys[id] = nil
end

return PositionComponentManager
