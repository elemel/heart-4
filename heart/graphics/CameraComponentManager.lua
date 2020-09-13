local class = require("heart.class")

local M = class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.transformComponents = assert(self.engine.componentManagers.transform)
  self.localTransforms = {}
  self.transforms = {}
  self.debugTransforms = {}
end

function M:createComponent(id, config)
 self.localTransforms[id] = love.math.newTransform()

  if config.transform then
    self.localTransforms[id]:setTransformation(unpack(config.transform))
  end

  local transform = self.transformComponents:getTransform(id)

  self.transforms[id] = love.math.newTransform():
    setMatrix(transform:getMatrix()):
    apply(self.localTransforms[id])

  self.debugTransforms[id] = love.math.newTransform():
    setMatrix(transform:getMatrix()):
    apply(self.localTransforms[id])
end

function M:destroyComponent(id)
  self.debugTransforms[id] = nil
  self.transforms[id] = nil
  self.localTransforms[id] = nil
end

return M
