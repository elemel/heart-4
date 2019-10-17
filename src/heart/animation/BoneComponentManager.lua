local class = require("heart.class")

local BoneComponentManager = class.newClass()

function BoneComponentManager:init(game, config)
  self.game = assert(game)
  self.transformComponents = assert(self.game.componentManagers.transform)
  self.previousTransforms = {}
end

function BoneComponentManager:createComponent(entityId, config)
  local transform = self.transformComponents.transforms[entityId]
  self.previousTransforms[entityId] = transform:clone()
end

function BoneComponentManager:destroyComponent(entityId)
  self.previousTransforms[entityId] = nil
end

return BoneComponentManager
