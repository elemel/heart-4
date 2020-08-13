local class = require("heart.class")
local heartMath = require("heart.math")

local M = class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.timerDomain = assert(engine.domains.timer)

  self.boneEntities = assert(self.engine.componentEntitySets.bone)
  self.meshInstanceEntities = assert(self.engine.componentEntitySets.meshInstance)

  self.boneComponents = assert(self.engine.componentManagers.bone)
  self.meshInstanceComponents = assert(self.engine.componentManagers.meshInstance)
  self.transformComponents = assert(self.engine.componentManagers.transform)
end

function M:handleEvent(dt)
  local previousTransforms = self.boneComponents.previousTransforms
  local transforms = self.transformComponents.transforms
  local t = self.timerDomain:getFraction()
  local meshInstanceTransforms = self.meshInstanceComponents.transforms

  for id in pairs(self.boneEntities) do
    if self.meshInstanceEntities[id] then
      heartMath.mixTransforms(
        previousTransforms[id], transforms[id], t, meshInstanceTransforms[id])
    end
  end
end

return M
