local class = require("heart.class")

local ParentConstraintComponentManager = class.newClass()

function ParentConstraintComponentManager:init(game, config)
  self.game = assert(game)
  self.transformComponents = assert(self.game.componentManagers.transform)
  self.localTransforms = {}
end

function ParentConstraintComponentManager:createComponent(entityId, config)
  local parentId = self.game.entityParents[entityId]
  local parentTransform = self.transformComponents.transforms[parentId]
  local transform = self.transformComponents.transforms[entityId]
  local localTransform = parentTransform:inverse():apply(transform)
  self.localTransforms[entityId] = localTransform
  return localTransform
end

function ParentConstraintComponentManager:destroyComponent(entityId)
  self.localTransforms[entityId] = nil
end

return ParentConstraintComponentManager
