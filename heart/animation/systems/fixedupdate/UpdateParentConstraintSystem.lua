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
  local enabledFlags = self.parentConstraintManager.enabledFlags

  for id in pairs(self.parentConstraintEntities) do
    if enabledFlags[id] then
      local parentId = parents[id]

      transforms[id]:
        reset():
        apply(transforms[parentId]):
        apply(localTransforms[id])
    end
  end
end

return M
