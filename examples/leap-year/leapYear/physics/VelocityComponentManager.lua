local M = heart.class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.positionComponents = assert(self.engine.componentManagers.position)

  self.previousXs = {}
  self.previousYs = {}
end

function M:createComponent(id, config)
  self.previousXs[id] = config.previousX or self.positionComponents.xs[id]
  self.previousYs[id] = config.previousY or self.positionComponents.ys[id]
end

function M:destroyComponent(id)
  self.previousYs[id] = nil
  self.previousXs[id] = nil
end

return M
