local M = heart.class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)

  self.defaultGravityX = config.defaultGravityX or 0
  self.defaultGravityY = config.defaultGravityY or 0

  self.gravityXs = {}
  self.gravityYs = {}
end

function M:createComponent(id, config)
  self.gravityXs[id] = config.gravityX or self.defaultGravityX
  self.gravityYs[id] = config.gravityY or self.defaultGravityY
end

function M:destroyComponent(id)
  self.gravityXs[id] = nil
  self.gravityYs[id] = nil
end

return M
