local class = require("heart.class")

local M = class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.transformComponents = assert(self.game.componentManagers.transform)
  self.imageResources = assert(game.resourceLoaders.image)
  self.images = {}
  self.zs = {}

  self.transforms = {}
end

function M:createComponent(entityId, config)
  local transform = self.transformComponents.transforms[entityId]

  if config.image then
    local imageFilename = assert(config.image)
    local image = self.imageResources:loadResource(imageFilename)
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
