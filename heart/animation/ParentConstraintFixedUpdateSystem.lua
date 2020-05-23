local class = require("heart.class")

local M = class.newClass()

function M:init(game, config)
  self.game = assert(game)

  self.parentConstraintEntities =
    assert(self.game.componentEntitySets.parentConstraint)

  self.parentConstraintComponents =
    assert(self.game.componentManagers.parentConstraint)

  self.transformComponents = assert(self.game.componentManagers.transform)
end

function M:handleEvent(dt)
  local parents = self.game.entityParents
  local transforms = self.transformComponents.transforms
  local localTransforms = self.parentConstraintComponents.localTransforms
  local enabledFlags = self.parentConstraintComponents.enabledFlags

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
