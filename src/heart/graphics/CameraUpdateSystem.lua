local class = require("heart.class")
local heartMath = require("heart.math")

local CameraUpdateSystem = class.newClass()

function CameraUpdateSystem:init(game, config)
  self.game = assert(game)
  self.timeDomain = assert(game.domains.time)
  self.cameraEntities = assert(self.game.componentEntitySets.camera)
  self.cameraComponents = assert(self.game.componentManagers.camera)
end

function CameraUpdateSystem:update(dt)
  local previousTransforms = self.cameraComponents.previousTransforms
  local transforms = self.cameraComponents.transforms
  local t = self.timeDomain.accumulatedDt / self.timeDomain.fixedDt
  local interpolatedTransforms = self.cameraComponents.interpolatedTransforms

  for id in pairs(self.cameraEntities) do
    heartMath.mixTransforms(
      previousTransforms[id], transforms[id], t, interpolatedTransforms[id])
  end
end

return CameraUpdateSystem
