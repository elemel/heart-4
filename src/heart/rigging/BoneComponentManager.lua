local class = require("heart.class")

local BoneComponentManager = class.newClass()

function BoneComponentManager:init(game, config)
  self.game = assert(game)
  self.transforms = {}
  self.previousTransforms = {}
  self.interpolatedTransforms = {}
end

function BoneComponentManager:createComponent(entityId, config, transform)
  local x = config.x or 0
  local y = config.y or 0
  local angle = config.angle or 0
  local scaleX = config.scaleX or 1
  local scaleY = config.scaleY or 1
  local originX = config.originX or 0
  local originY = config.originY or 0
  local shearX = config.shearX or 0
  local shearY = config.shearY or 0

  transform = transform * love.math.newTransform(
      x, y, angle, scaleX, scaleY, originX, originY, shearX, shearY)

  self.transforms[entityId] = transform
  self.previousTransforms[entityId] = transform:clone()
  self.interpolatedTransforms[entityId] = transform:clone()
  return transform
end

function BoneComponentManager:destroyComponent(entityId)
  self.transforms[entityId] = nil
  self.previousTransforms[entityId] = nil
  self.interpolatedTransforms[entityId] = nil
end

return BoneComponentManager
