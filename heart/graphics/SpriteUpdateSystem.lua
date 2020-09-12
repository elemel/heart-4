local class = require("heart.class")
local heartMath = require("heart.math")

local M = class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.timerDomain = assert(engine.domains.timer)

  self.spriteEntities = assert(self.engine.componentEntitySets.sprite)
  self.transformEntities = assert(self.engine.componentEntitySets.transform)

  self.spriteComponents = assert(self.engine.componentManagers.sprite)
  self.transformComponents = assert(self.engine.componentManagers.transform)
end

function M:handleEvent(dt)
  local t = self.timerDomain:getFraction()
  local localSpriteTransforms = self.spriteComponents.localTransforms
  local spriteTransforms = self.spriteComponents.transforms

  for id in pairs(self.spriteEntities) do
    local transform = self.transformComponents:getInterpolatedTransform(id, t)
    spriteTransforms[id]:setMatrix(transform:getMatrix()):apply(localSpriteTransforms[id])
  end
end

return M
