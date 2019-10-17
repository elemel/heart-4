local class = require("heart.class")

local CameraComponentManager = class.newClass()

function CameraComponentManager:init(game, config)
  self.game = assert(game)
  self.transformComponents = assert(self.game.componentManagers.transform)
  self.transforms = {}
end

function CameraComponentManager:createComponent(id, config)
  local transform = self.transformComponents.transforms[id]
  self.transforms[id] = transform:clone()
end

function CameraComponentManager:destroyComponent(id)
  self.transforms[id] = nil
end

return CameraComponentManager
