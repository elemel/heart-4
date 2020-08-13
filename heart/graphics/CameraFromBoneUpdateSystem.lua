local class = require("heart.class")
local heartMath = require("heart.math")

local M = class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.timerDomain = assert(engine.domains.timer)

  self.boneEntities = assert(self.engine.componentEntitySets.bone)
  self.cameraEntities = assert(self.engine.componentEntitySets.camera)

  self.boneComponents = assert(self.engine.componentManagers.bone)
  self.cameraComponents = assert(self.engine.componentManagers.camera)
  self.transformComponents = assert(self.engine.componentManagers.transform)
end

function M:handleEvent(dt)
  local previousTransforms = self.boneComponents.previousTransforms
  local transforms = self.transformComponents.transforms
  local t = self.timerDomain:getFraction()
  local cameraTransforms = self.cameraComponents.transforms

  for id in pairs(self.cameraEntities) do
    if self.boneEntities[id] then
      heartMath.mixTransforms(
        previousTransforms[id], transforms[id], t, cameraTransforms[id])
    end
  end
end

return M
