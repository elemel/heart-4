local class = require("heart.class")
local heartMath = require("heart.math")

local M = class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.timerDomain = assert(game.domains.timer)

  self.boneEntities = assert(self.game.componentEntitySets.bone)
  self.spriteEntities = assert(self.game.componentEntitySets.sprite)

  self.boneComponents = assert(self.game.componentManagers.bone)
  self.transformComponents = assert(self.game.componentManagers.transform)
  self.spriteComponents = assert(self.game.componentManagers.sprite)
end

function M:update(dt)
  local previousTransforms = self.boneComponents.previousTransforms
  local transforms = self.transformComponents.transforms
  local t = self.timerDomain.accumulatedDt / self.timerDomain.fixedDt
  local spriteTransforms = self.spriteComponents.transforms

  for id in pairs(self.boneEntities) do
    if self.spriteEntities[id] then
      heartMath.mixTransforms(
        previousTransforms[id], transforms[id], t, spriteTransforms[id])
    end
  end
end

return M
