local class = require("heart.class")
local heartMath = require("heart.math")

local M = class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.timerDomain = assert(game.domains.timer)

  self.boneEntities = assert(self.game.componentEntitySets.bone)
  self.cameraEntities = assert(self.game.componentEntitySets.camera)

  self.boneManager = assert(self.game.componentManagers.bone)
  self.transformManager = assert(self.game.componentManagers.transform)
  self.cameraManager = assert(self.game.componentManagers.camera)
end

function M:__call(dt)
  local previousTransforms = self.boneManager.previousTransforms
  local transforms = self.transformManager.transforms
  local t = self.timerDomain.accumulatedDt / self.timerDomain.fixedDt
  local cameraTransforms = self.cameraManager.transforms

  for id in pairs(self.cameraEntities) do
    if self.boneEntities[id] then
      heartMath.mixTransforms(
        previousTransforms[id], transforms[id], t, cameraTransforms[id])
    end
  end
end

return M
