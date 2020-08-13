local M = heart.class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.transformComponents = assert(self.engine.componentManagers.transform)
  self.xs = {}
  self.ys = {}
end

function M:createComponent(id, config)
  local x = config.x or 0
  local y = config.y or 0

  local transform = self.transformComponents.transforms[id]

  if transform then
    x, y = transform:transformPoint(x, y)
  end

  self.xs[id] = x
  self.ys[id] = y
end

function M:destroyComponent(id)
  self.xs[id] = nil
  self.ys[id] = nil
end

return M
