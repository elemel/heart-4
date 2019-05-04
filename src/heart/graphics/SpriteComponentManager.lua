local class = require("heart.class")

local SpriteComponentManager = class.newClass()

function SpriteComponentManager:init(game, config)
  self.game = assert(game)
  self.imageLoader = assert(game.resourceLoaders.image)
  self.images = {}
  self.zs = {}
end

function SpriteComponentManager:createComponent(entityId, config, transform)
  local imageFilename = assert(config.image)
  local image = self.imageLoader:load(imageFilename)
  self.images[entityId] = image

  self.zs[entityId] = config.z or 0
end

function SpriteComponentManager:destroyComponent(entityId)
  self.images[entityId] = nil
  self.zs[entityId] = nil
end

return SpriteComponentManager
