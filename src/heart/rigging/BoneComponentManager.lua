local class = require("heart.class")

local BoneComponentManager = class.newClass()

function BoneComponentManager:init(game, config)
  self.game = assert(game)
  self.transforms = {}
end

function BoneComponentManager:createComponent(entityId, config, transform)
  self.transforms[entityId] = transform:clone()
end

function BoneComponentManager:destroyComponent(entityId)
  self.transforms[entityId] = nil
end

return BoneComponentManager
