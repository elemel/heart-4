local class = require("heart.class")
local heartMath = require("heart.math")

local M = class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.timerDomain = assert(engine.domains.timer)

  self.cameraEntities = assert(self.engine.componentEntitySets.camera)

  self.cameraComponents = assert(self.engine.componentManagers.camera)
  self.transformComponents = assert(self.engine.componentManagers.transform)
end

function M:handleEvent(dt)
  local t = self.timerDomain:getFraction()

  local localCameraTransforms = self.cameraComponents.localTransforms
  local cameraTransforms = self.cameraComponents.transforms
  local cameraDebugTransforms = self.cameraComponents.debugTransforms

  for id in pairs(self.cameraEntities) do
    local interpolatedTransform = self.transformComponents:getInterpolatedTransform(id, t)
    cameraTransforms[id]:setMatrix(interpolatedTransform:getMatrix()):apply(localCameraTransforms[id])

    local transform = self.transformComponents:getTransform(id)
    cameraDebugTransforms[id]:setMatrix(transform:getMatrix()):apply(localCameraTransforms[id])
  end
end

return M
