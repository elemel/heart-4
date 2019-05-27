local class = require("heart.class")

local CameraComponentManager = class.newClass()

function CameraComponentManager:init(game, config)
  self.game = assert(game)

  self.transforms = {}
  self.previousTransforms = {}
  self.interpolatedTransforms = {}
end

function CameraComponentManager:createComponent(id, config, transform)
  self.transforms[id] = transform:clone()
  self.previousTransforms[id] = transform:clone()
  self.interpolatedTransforms[id] = transform:clone()
end

function CameraComponentManager:destroyComponent(id)
  self.transforms[id] = nil
  self.previousTransforms[id] = nil
  self.interpolatedTransforms[id] = nil
end

return CameraComponentManager
