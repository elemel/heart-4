local class = require("heart.class")

local ParentConstraintFixedUpdateSystem = class.newClass()

function ParentConstraintFixedUpdateSystem:init(game, config)
  self.game = assert(game)
  self.bones = assert(self.game.componentManagers.bone)

  self.parentConstraintComponents =
    assert(self.game.componentManagers.parentConstraint)

  self.parentConstraintEntities =
    assert(self.game.componentEntitySets.parentConstraint)
end

function ParentConstraintFixedUpdateSystem:fixedUpdate(dt)
  local parents = self.game.entityParents
  local transforms = self.bones.transforms
  local localTransforms = self.parentConstraintComponents.localTransforms

  for entityId in pairs(self.parentConstraintEntities) do
    local parentId = parents[entityId]

    transforms[entityId]:
      reset():
      apply(transforms[parentId]):
      apply(localTransforms[entityId])
  end
end

return ParentConstraintFixedUpdateSystem
