local VelocityComponentManager = heart.class.newClass()

function VelocityComponentManager:init(game, config)
  self.game = assert(game)
  self.positionComponents = assert(self.game.componentManagers.position)

  self.previousXs = {}
  self.previousYs = {}
end

function VelocityComponentManager:createComponent(id, config, transform)
  self.previousXs[id] = config.previousX or self.positionComponents.xs[id]
  self.previousYs[id] = config.previousY or self.positionComponents.ys[id]
end

function VelocityComponentManager:destroyComponent(id)
  self.previousYs[id] = nil
  self.previousXs[id] = nil
end

return VelocityComponentManager
