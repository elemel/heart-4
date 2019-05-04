local class = require("heart.class")

local ParentedBoneComponentManager = class.newClass()

function ParentedBoneComponentManager:init(game, config)
  self.game = assert(game)
  self.bones = assert(self.game.componentManagers.bone)
  self.localTransforms = {}
end

function ParentedBoneComponentManager:createComponent(
  entityId, config, transform)

  local parentId = self.game.entityParents[entityId]
  local parentTransform = self.bones.transforms[parentId]
  local transform = self.bones.transforms[entityId]
  local localTransform = parentTransform:inverse():apply(transform)
  self.localTransforms[entityId] = localTransform
  return localTransform
end

function ParentedBoneComponentManager:destroyComponent(entityId)
  self.localTransforms[entityId] = nil
end

return ParentedBoneComponentManager
