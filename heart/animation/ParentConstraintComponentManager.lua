local class = require("heart.class")

local M = class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.transformComponents = assert(self.engine.componentManagers.transform)
  self.localTransforms = {}
  self.enabledFlags = {}
end

function M:createComponent(entityId, config)
  local parentId = self.engine.entityParents[entityId]
  local parentTransform = self.transformComponents.transforms[parentId]
  local transform = self.transformComponents.transforms[entityId]
  local localTransform = parentTransform:inverse():apply(transform)
  self.localTransforms[entityId] = localTransform
  self.enabledFlags[entityId] = config.enabled ~= false
  return localTransform
end

function M:destroyComponent(entityId)
  self.localTransforms[entityId] = nil
  self.enabledFlags[entityId] = nil
end

return M
