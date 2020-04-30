local class = require("heart.class")

local M = class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.transformComponents = assert(self.game.componentManagers.transform)
  self.previousTransforms = {}
end

function M:createComponent(entityId, config)
  local transform = self.transformComponents.transforms[entityId]
  self.previousTransforms[entityId] = transform:clone()
end

function M:destroyComponent(entityId)
  self.previousTransforms[entityId] = nil
end

return M
