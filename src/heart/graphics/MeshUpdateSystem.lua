local class = require("heart.class")
local heartMath = require("heart.math")

local MeshUpdateSystem = class.newClass()

function MeshUpdateSystem:init(game, config)
  self.game = assert(game)
  self.timeDomain = assert(game.domains.time)
  self.boneEntities = assert(self.game.componentEntitySets.bone)
  self.meshEntities = assert(self.game.componentEntitySets.mesh)
  self.meshComponents = assert(self.game.componentManagers.mesh)
end

function MeshUpdateSystem:update(dt)
  local transforms = self.meshComponents.transforms
  local previousTransforms = self.meshComponents.previousTransforms
  local t = self.timeDomain.accumulatedTimeStep / self.timeDomain.fixedTimeStep
  local interpolatedTransforms = self.meshComponents.interpolatedTransforms

  for id in pairs(self.boneEntities) do
    if self.meshEntities[id] then
      heartMath.mixTransforms(
        transforms[id], previousTransforms[id], t, interpolatedTransforms[id])
    end
  end
end

return MeshUpdateSystem
