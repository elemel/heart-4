local class = require("heart.class")
local heartMath = require("heart.math")

local M = class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.timerDomain = assert(game.domains.timer)

  self.boneEntities = assert(self.game.componentEntitySets.bone)
  self.spriteEntities = assert(self.game.componentEntitySets.sprite)

  self.boneManager = assert(self.game.componentManagers.bone)
  self.transformManager = assert(self.game.componentManagers.transform)
  self.spriteManager = assert(self.game.componentManagers.sprite)
end

function M:__call(dt)
  local previousTransforms = self.boneManager.previousTransforms
  local transforms = self.transformManager.transforms
  local t = self.timerDomain.accumulatedDt / self.timerDomain.fixedDt
  local spriteTransforms = self.spriteManager.transforms

  for id in pairs(self.boneEntities) do
    if self.spriteEntities[id] then
      heartMath.mixTransforms(
        previousTransforms[id], transforms[id], t, spriteTransforms[id])
    end
  end
end

return M
