local class = require("heart.class")
local heartMath = require("heart.math")

local BoneToCameraUpdateSystem = class.newClass()

function BoneToCameraUpdateSystem:init(game, config)
  self.game = assert(game)
  self.timeDomain = assert(game.domains.time)

  self.boneEntities = assert(self.game.componentEntitySets.bone)
  self.cameraEntities = assert(self.game.componentEntitySets.camera)

  self.boneComponents = assert(self.game.componentManagers.bone)
  self.transformComponents = assert(self.game.componentManagers.transform)
  self.cameraComponents = assert(self.game.componentManagers.camera)
end

function BoneToCameraUpdateSystem:update(dt)
  local previousTransforms = self.boneComponents.previousTransforms
  local transforms = self.transformComponents.transforms
  local t = self.timeDomain.accumulatedDt / self.timeDomain.fixedDt
  local cameraTransforms = self.cameraComponents.transforms

  for id in pairs(self.cameraEntities) do
    if self.boneEntities[id] then
      heartMath.mixTransforms(
        previousTransforms[id], transforms[id], t, cameraTransforms[id])
    end
  end
end

return BoneToCameraUpdateSystem
