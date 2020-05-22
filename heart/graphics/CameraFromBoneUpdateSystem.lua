local class = require("heart.class")
local heartMath = require("heart.math")

local M = class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.timerDomain = assert(game.domains.timer)

  self.boneEntities = assert(self.game.componentEntitySets.bone)
  self.cameraEntities = assert(self.game.componentEntitySets.camera)

  self.boneComponents = assert(self.game.componentManagers.bone)
  self.cameraComponents = assert(self.game.componentManagers.camera)
  self.transformComponents = assert(self.game.componentManagers.transform)
end

function M:__call(dt)
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
