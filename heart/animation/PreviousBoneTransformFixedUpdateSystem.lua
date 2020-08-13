local class = require("heart.class")

local M = class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.boneEntities = assert(self.engine.componentEntitySets.bone)
  self.boneComponents = assert(self.engine.componentManagers.bone)
  self.transformComponents = assert(self.engine.componentManagers.transform)
end

function M:handleEvent(dt)
  local previousTransforms = self.boneComponents.previousTransforms
  local transforms = self.transformComponents.transforms

  for id in pairs(self.boneEntities) do
    previousTransforms[id]:reset():apply(transforms[id])
  end
end

return M
