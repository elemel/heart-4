local class = require("heart.class")

local SpriteComponentManager = class.newClass()

function SpriteComponentManager:init(game, config)
  self.game = assert(game)
  self.imageResources = assert(game.resourceLoaders.image)
  self.images = {}
  self.zs = {}

  self.transforms = {}
  self.previousTransforms = {}
  self.interpolatedTransforms = {}
end

function SpriteComponentManager:createComponent(entityId, config, transform)
  local imageFilename = assert(config.image)
  local image = self.imageResources:loadResource(imageFilename)
  self.images[entityId] = image
  self.zs[entityId] = config.z or 0

  self.transforms[entityId] = transform:clone()
  self.previousTransforms[entityId] = transform:clone()
  self.interpolatedTransforms[entityId] = transform:clone()
end

function SpriteComponentManager:destroyComponent(entityId)
  self.images[entityId] = nil
  self.zs[entityId] = nil

  self.transforms[entityId] = nil
  self.previousTransforms[entityId] = nil
  self.interpolatedTransforms[entityId] = nil
end

return SpriteComponentManager
