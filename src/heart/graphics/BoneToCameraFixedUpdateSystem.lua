local class = require("heart.class")

local BoneToCameraFixedUpdateSystem = class.newClass()

function BoneToCameraFixedUpdateSystem:init(game, config)
  self.game = assert(game)

  self.boneEntities = assert(self.game.componentEntitySets.bone)
  self.cameraEntities = assert(self.game.componentEntitySets.camera)

  self.boneComponents = assert(self.game.componentManagers.bone)
  self.cameraComponents = assert(self.game.componentManagers.camera)
end

function BoneToCameraFixedUpdateSystem:fixedUpdate(dt)
  local boneTransforms = self.boneComponents.transforms
  local cameraTransforms = self.cameraComponents.transforms
  local previousCameraTransforms = self.cameraComponents.previousTransforms

  for id in pairs(self.cameraEntities) do
    if self.boneEntities[id] then
      cameraTransforms[id], previousCameraTransforms[id] =
        previousCameraTransforms[id], cameraTransforms[id]

      cameraTransforms[id]:reset():apply(boneTransforms[id])
    end
  end
end

return BoneToCameraFixedUpdateSystem
