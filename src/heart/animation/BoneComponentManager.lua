local class = require("heart.class")
local heartMath = require("heart.math")

local BoneComponentManager = class.newClass()

function BoneComponentManager:init(game, config)
  self.game = assert(game)
  self.transforms = {}
end

function BoneComponentManager:createComponent(entityId, config, transform)
  self.transforms[entityId] = transform:clone()

  if config.flat then
    local x, y = self.transforms[entityId]:transformPoint(0, 0)
    local angle = heartMath.transformAngle(self.transforms[entityId], 0)
    self.transforms[entityId]:setTransformation(x, y, angle)
  end
end

function BoneComponentManager:destroyComponent(entityId)
  self.transforms[entityId] = nil
end

return BoneComponentManager
