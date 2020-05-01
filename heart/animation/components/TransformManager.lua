local class = require("heart.class")

local M = class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.transforms = {}
end

function M:createComponent(id, config)
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

function M:destroyComponent(id)
  self.transforms[id] = nil
end

return M
