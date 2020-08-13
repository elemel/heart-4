local class = require("heart.class")

local M = class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)

  self.parentConstraintEntities =
    assert(self.engine.componentEntitySets.parentConstraint)

  self.parentConstraintComponents =
    assert(self.engine.componentManagers.parentConstraint)

  self.transformComponents = assert(self.engine.componentManagers.transform)
end

function M:handleEvent(dt)
  local parents = self.engine.entityParents
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
