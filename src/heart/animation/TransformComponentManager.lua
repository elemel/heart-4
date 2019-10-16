local class = require("heart.class")

local TransformComponentManager = class.newClass()

function TransformComponentManager:init(game, config)
  self.game = assert(game)
  self.transforms = {}
end

function TransformComponentManager:createComponent(id, config)
  local transform = love.math.newTransform()

  if config.transform then
    transform:setTransformation(unpack(config.transform))
  end

  local parentId = self.game.entityParents[id]
  local parentTransform = parentId and self.transforms[parentId]

  if parentTransform then
    transform = parentTransform * transform
  end

  self.transforms[id] = transform
end

function TransformComponentManager:destroyComponent(id)
  self.transforms[id] = nil
end

return TransformComponentManager
