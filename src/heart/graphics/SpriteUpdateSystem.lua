local class = require("heart.class")
local heartMath = require("heart.math")

local SpriteUpdateSystem = class.newClass()

function SpriteUpdateSystem:init(game, config)
  self.game = assert(game)
  self.timeDomain = assert(game.domains.time)
  self.boneEntities = assert(self.game.componentEntitySets.bone)
  self.spriteEntities = assert(self.game.componentEntitySets.sprite)
  self.spriteComponents = assert(self.game.componentManagers.sprite)
end

function SpriteUpdateSystem:update(dt)
  local previousTransforms = self.spriteComponents.previousTransforms
  local transforms = self.spriteComponents.transforms
  local t = self.timeDomain.accumulatedDt / self.timeDomain.fixedDt
  local interpolatedTransforms = self.spriteComponents.interpolatedTransforms

  for id in pairs(self.boneEntities) do
    if self.spriteEntities[id] then
      heartMath.mixTransforms(
        previousTransforms[id], transforms[id], t, interpolatedTransforms[id])
    end
  end
end

return SpriteUpdateSystem
