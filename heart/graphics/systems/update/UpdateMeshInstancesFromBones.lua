local class = require("heart.class")
local heartMath = require("heart.math")

local M = class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.timerDomain = assert(game.domains.timer)

  self.boneEntities = assert(self.game.componentEntitySets.bone)
  self.meshInstanceEntities = assert(self.game.componentEntitySets.meshInstance)

  self.boneManager = assert(self.game.componentManagers.bone)
  self.transformManager = assert(self.game.componentManagers.transform)
  self.meshInstanceManager = assert(self.game.componentManagers.meshInstance)
end

function M:update(dt)
  local previousTransforms = self.boneManager.previousTransforms
  local transforms = self.transformManager.transforms
  local t = self.timerDomain.accumulatedDt / self.timerDomain.fixedDt
  local meshInstanceTransforms = self.meshInstanceManager.transforms

  for id in pairs(self.boneEntities) do
    if self.meshInstanceEntities[id] then
      heartMath.mixTransforms(
        previousTransforms[id], transforms[id], t, meshInstanceTransforms[id])
    end
  end
end

return M
