local class = require("heart.class")

local M = class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.transformManager = assert(self.game.componentManagers.transform)

  self.parentConstraintManager =
    assert(self.game.componentManagers.parentConstraint)

  self.parentConstraintEntities =
    assert(self.game.componentEntitySets.parentConstraint)
end

function M:__call(dt)
  local parents = self.game.entityParents
  local transforms = self.transformManager.transforms
  local localTransforms = self.parentConstraintManager.localTransforms

  for entityId in pairs(self.parentConstraintEntities) do
    local parentId = parents[entityId]

    transforms[entityId]:
      reset():
      apply(transforms[parentId]):
      apply(localTransforms[entityId])
  end
end

return M
