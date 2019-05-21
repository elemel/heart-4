local class = require("heart.class")

local BoneToSpriteFixedUpdateSystem = class.newClass()

function BoneToSpriteFixedUpdateSystem:init(game, config)
  self.game = assert(game)
  self.boneComponents = assert(self.game.componentManagers.bone)
  self.spriteComponents = assert(self.game.componentManagers.sprite)
  self.boneEntities = assert(self.game.componentEntitySets.bone)
  self.spriteEntities = assert(self.game.componentEntitySets.sprite)
end

function BoneToSpriteFixedUpdateSystem:fixedUpdate(dt)
  local boneTransforms = self.boneComponents.transforms
  local spriteTransforms = self.spriteComponents.transforms
  local previousSpriteTransforms = self.spriteComponents.previousTransforms

  for id in pairs(self.boneEntities) do
    if self.spriteEntities[id] then
      spriteTransforms[id], previousSpriteTransforms[id] =
        previousSpriteTransforms[id], spriteTransforms[id]

      spriteTransforms[id]:reset():apply(boneTransforms[id])
    end
  end
end

return BoneToSpriteFixedUpdateSystem
