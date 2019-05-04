local class = require("heart.class")

local ParentedBoneFixedUpdateSystem = class.newClass()

function ParentedBoneFixedUpdateSystem:init(game, config)
  self.game = assert(game)
  self.bones = assert(self.game.componentManagers.bone)
  self.parentedBones = assert(self.game.componentManagers.parentedBone)

  self.parentedBoneEntities =
    assert(self.game.componentEntitySets.parentedBone)
end

function ParentedBoneFixedUpdateSystem:fixedUpdate(dt)
  local parents = self.game.entityParents
  local transforms = self.bones.transforms
  local localTransforms = self.parentedBones.localTransforms

  for entityId in pairs(self.parentedBoneEntities) do
    local parentId = parents[entityId]

    transforms[entityId]:
      reset():
      apply(transforms[parentId]):
      apply(localTransforms[entityId])
  end
end

return ParentedBoneFixedUpdateSystem
