local class = require("heart.class")
local heartMath = require("heart.math")

local BoneToMeshUpdateSystem = class.newClass()

function BoneToMeshUpdateSystem:init(game, config)
  self.game = assert(game)
  self.timeDomain = assert(game.domains.time)

  self.boneEntities = assert(self.game.componentEntitySets.bone)
  self.meshEntities = assert(self.game.componentEntitySets.mesh)

  self.boneComponents = assert(self.game.componentManagers.bone)
  self.transformComponents = assert(self.game.componentManagers.transform)
  self.meshComponents = assert(self.game.componentManagers.mesh)
end

function BoneToMeshUpdateSystem:update(dt)
  local previousTransforms = self.boneComponents.previousTransforms
  local transforms = self.transformComponents.transforms
  local t = self.timeDomain.accumulatedDt / self.timeDomain.fixedDt
  local meshTransforms = self.meshComponents.transforms

  for id in pairs(self.boneEntities) do
    if self.meshEntities[id] then
      heartMath.mixTransforms(
        previousTransforms[id], transforms[id], t, meshTransforms[id])
    end
  end
end

return BoneToMeshUpdateSystem
