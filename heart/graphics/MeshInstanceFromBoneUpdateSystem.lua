local class = require("heart.class")
local heartMath = require("heart.math")

local M = class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.timerDomain = assert(game.domains.timer)

  self.boneEntities = assert(self.game.componentEntitySets.bone)
  self.meshInstanceEntities = assert(self.game.componentEntitySets.meshInstance)

  self.boneComponents = assert(self.game.componentManagers.bone)
  self.meshInstanceComponents = assert(self.game.componentManagers.meshInstance)
  self.transformComponents = assert(self.game.componentManagers.transform)
end

function M:__call(dt)
  local previousTransforms = self.boneComponents.previousTransforms
  local transforms = self.transformComponents.transforms
  local t = self.timerDomain:getFraction()
  local meshInstanceTransforms = self.meshInstanceComponents.transforms

  for id in pairs(self.boneEntities) do
    if self.meshInstanceEntities[id] then
      heartMath.mixTransforms(
        previousTransforms[id], transforms[id], t, meshInstanceTransforms[id])
    end
  end
end

return M
