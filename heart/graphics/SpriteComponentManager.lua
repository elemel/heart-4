local class = require("heart.class")

local M = class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.transformComponents = assert(self.engine.componentManagers.transform)
  self.imageLoader = assert(engine.resourceLoaders.image)
  self.images = {}
  self.zs = {}

  self.transforms = {}
end

function M:createComponent(entityId, config)
  local transform = self.transformComponents.transforms[entityId]

  if config.image then
    local imageFilename = assert(config.image)
    local image = self.imageLoader:loadResource(imageFilename)
    self.images[entityId] = image
  end

  self.zs[entityId] = config.z or 0
  self.transforms[entityId] = transform:clone()
end

function M:destroyComponent(entityId)
  self.images[entityId] = nil
  self.zs[entityId] = nil
  self.transforms[entityId] = nil
end

return M
