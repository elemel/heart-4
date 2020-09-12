local class = require("heart.class")

local M = class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.transformComponents = assert(self.engine.componentManagers.transform)
  self.imageLoader = assert(engine.resourceLoaders.image)
  self.images = {}
  self.localTransforms = {}
  self.transforms = {}
end

function M:createComponent(id, config)
  self.images[id] = self.imageLoader:loadResource(config.image)
  self.localTransforms[id] = love.math.newTransform()

  if config.transform then
    self.localTransforms[id]:setTransformation(unpack(config.transform))
  end

  local transform = self.transformComponents:getTransform(id)

  self.transforms[id] = love.math.newTransform():
    setMatrix(transform:getMatrix()):
    apply(self.localTransforms[id])
end

function M:destroyComponent(id)
  self.transforms[id] = nil
  self.localTransforms[id] = nil
  self.images[id] = nil
end

return M
