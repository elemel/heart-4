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
  local cameraTransforms = self.cameraComponents.transforms

  for id in pairs(self.cameraEntities) do
    local transform = self.transformComponents:getInterpolatedTransform(id, t)
    cameraTransforms[id]:setMatrix(transform:getMatrix())
  end
end

return M
