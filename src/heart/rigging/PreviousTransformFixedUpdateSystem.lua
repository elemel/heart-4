local class = require("heart.class")

local PreviousTransformFixedUpdateSystem = class.newClass()

function PreviousTransformFixedUpdateSystem:init(game, config)
  self.game = assert(game)
  self.bones = assert(self.game.componentManagers.bone)

  self.interpolatedBoneEntities =
    assert(self.game.componentEntitySets.interpolatedBone)
end

function PreviousTransformFixedUpdateSystem:fixedUpdate(dt)
  local transforms = self.bones.transforms
  local previousTransforms = self.bones.previousTransforms

  for entityId in pairs(self.interpolatedBoneEntities) do
    previousTransforms[entityId]:
      reset():
      apply(transforms[entityId])
  end
end

return PreviousTransformFixedUpdateSystem
