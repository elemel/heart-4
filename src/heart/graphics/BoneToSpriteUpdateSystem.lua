local class = require("heart.class")
local heartMath = require("heart.math")

local BoneToSpriteUpdateSystem = class.newClass()

function BoneToSpriteUpdateSystem:init(game, config)
  self.game = assert(game)
  self.timeDomain = assert(game.domains.time)

  self.boneEntities = assert(self.game.componentEntitySets.bone)
  self.spriteEntities = assert(self.game.componentEntitySets.sprite)

  self.boneComponents = assert(self.game.componentManagers.bone)
  self.transformComponents = assert(self.game.componentManagers.transform)
  self.spriteComponents = assert(self.game.componentManagers.sprite)
end

function BoneToSpriteUpdateSystem:update(dt)
  local previousTransforms = self.boneComponents.previousTransforms
  local transforms = self.transformComponents.transforms
  local t = self.timeDomain.accumulatedDt / self.timeDomain.fixedDt
  local spriteTransforms = self.spriteComponents.transforms

  for id in pairs(self.boneEntities) do
    if self.spriteEntities[id] then
      heartMath.mixTransforms(
        previousTransforms[id], transforms[id], t, spriteTransforms[id])
    end
  end
end

return BoneToSpriteUpdateSystem
