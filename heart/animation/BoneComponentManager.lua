local class = require("heart.class")

local M = class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.transformComponents = assert(self.engine.componentManagers.transform)
  self.previousTransforms = {}
end

function M:createComponent(entityId, config)
  local transform = self.transformComponents.transforms[entityId]
  self.previousTransforms[entityId] = transform:clone()
end

function M:destroyComponent(entityId)
  self.previousTransforms[entityId] = nil
end

return M
