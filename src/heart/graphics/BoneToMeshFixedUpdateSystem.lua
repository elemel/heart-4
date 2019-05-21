local class = require("heart.class")

local BoneToMeshFixedUpdateSystem = class.newClass()

function BoneToMeshFixedUpdateSystem:init(game, config)
  self.game = assert(game)
  self.boneEntities = assert(self.game.componentEntitySets.bone)
  self.meshEntities = assert(self.game.componentEntitySets.mesh)
  self.boneComponents = assert(self.game.componentManagers.bone)
  self.meshComponents = assert(self.game.componentManagers.mesh)
end

function BoneToMeshFixedUpdateSystem:fixedUpdate(dt)
  local boneTransforms = self.boneComponents.transforms
  local meshTransforms = self.meshComponents.transforms
  local previousMeshTransforms = self.meshComponents.previousTransforms

  for id in pairs(self.boneEntities) do
    if self.meshEntities[id] then
      meshTransforms[id], previousMeshTransforms[id] =
        previousMeshTransforms[id], meshTransforms[id]

      meshTransforms[id]:reset():apply(boneTransforms[id])
    end
  end
end

return BoneToMeshFixedUpdateSystem
