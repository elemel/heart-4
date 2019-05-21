local class = require("heart.class")
local mathUtils = require("heart.math.utils")

local SpriteUpdateSystem = class.newClass()

function SpriteUpdateSystem:init(game, config)
  self.game = assert(game)
  self.timeDomain = assert(game.domains.time)
  self.boneEntities = assert(self.game.componentEntitySets.bone)
  self.spriteEntities = assert(self.game.componentEntitySets.sprite)
  self.spriteComponents = assert(self.game.componentManagers.sprite)
end

function SpriteUpdateSystem:update(dt)
  local transforms = self.spriteComponents.transforms
  local previousTransforms = self.spriteComponents.previousTransforms
  local t = self.timeDomain.accumulatedTimeStep / self.timeDomain.fixedTimeStep
  local interpolatedTransforms = self.spriteComponents.interpolatedTransforms

  for id in pairs(self.boneEntities) do
    if self.spriteEntities[id] then
      mathUtils.mixTransforms(
        transforms[id], previousTransforms[id], t, interpolatedTransforms[id])
    end
  end
end

return SpriteUpdateSystem
