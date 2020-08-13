local class = require("heart.class")
local heartMath = require("heart.math")

local M = class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.timerDomain = assert(engine.domains.timer)

  self.boneEntities = assert(self.engine.componentEntitySets.bone)
  self.spriteEntities = assert(self.engine.componentEntitySets.sprite)

  self.boneComponents = assert(self.engine.componentManagers.bone)
  self.transformComponents = assert(self.engine.componentManagers.transform)
  self.spriteComponents = assert(self.engine.componentManagers.sprite)
end

function M:handleEvent(dt)
  local previousTransforms = self.boneComponents.previousTransforms
  local transforms = self.transformComponents.transforms
  local t = self.timerDomain:getFraction()
  local spriteTransforms = self.spriteComponents.transforms
  local zs = self.spriteComponents.zs

  for id in pairs(self.boneEntities) do
    if self.spriteEntities[id] then
      _, zs[id] = heartMath.mixTransforms(
        previousTransforms[id], transforms[id], t, spriteTransforms[id])
    end
  end
end

return M
