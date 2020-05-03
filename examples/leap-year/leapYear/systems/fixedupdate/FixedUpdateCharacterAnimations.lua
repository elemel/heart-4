local M = heart.class.newClass()

function M:init(game, config)
  self.game = assert(game)

  self.characterEntities = assert(self.game.componentEntitySets.character)
  self.characterManager = assert(self.game.componentManagers.character)

  self.transformManager = assert(self.game.componentManagers.transform)
  self.boneManager = assert(self.game.componentManagers.bone)
  self.positionManager = assert(self.game.componentManagers.position)
  self.velocityManager = assert(self.game.componentManagers.velocity)
  self.spriteManager = assert(self.game.componentManagers.sprite)
  self.characterStateManager = assert(self.game.componentManagers.characterState)

  self.imageLoader = assert(self.game.assetLoaders.image)
end

function M:fixedupdate(dt)
  local directionXs = self.characterManager.directionXs

  local previousXs = self.velocityManager.previousXs
  local previousYs = self.velocityManager.previousYs

  local xs = self.positionManager.xs
  local ys = self.positionManager.ys

  local images = self.spriteManager.images

  local previousTransforms = self.boneManager.previousTransforms
  local transforms = self.transformManager.transforms

  local states = self.characterStateManager.states
  local images = self.spriteManager.images

  local characterTypes = self.characterManager.characterTypes
  local skins = self.characterManager.skins

  local animationTimes = self.characterManager.animationTimes

  for id in pairs(self.characterEntities) do
    local characterType = characterTypes[id]
    local skin = skins[characterType]
    local state = states[id]

    if state == "crouching" then
      images[id] = self.imageLoader:loadAsset(skin.attacking)
    elseif state == "dead" then
      images[id] = self.imageLoader:loadAsset(skin.dead)
    elseif state == "falling" then
      images[id] = self.imageLoader:loadAsset(skin.jumping)
    elseif state == "gliding" then
      images[id] = self.imageLoader:loadAsset(skin.jumping)
    elseif state == "running" then
      animationTimes[id] = animationTimes[id] + 5 * dt
      local frame = animationTimes[id] % 1 < 0.5 and skin.running or skin.jumping
      images[id] = self.imageLoader:loadAsset(frame)
    elseif state == "sliding" then
      images[id] = self.imageLoader:loadAsset(skin.attacking)
    elseif state == "sneaking" then
      animationTimes[id] = animationTimes[id] + 2 * dt
      local frame = animationTimes[id] % 1 < 0.5 and skin.running or skin.jumping
      images[id] = self.imageLoader:loadAsset(frame)
    elseif state == "standing" then
      images[id] = self.imageLoader:loadAsset(skin.idle)
    elseif state == "walking" then
      animationTimes[id] = animationTimes[id] + 3 * dt
      local frame = animationTimes[id] % 1 < 0.5 and skin.running or skin.jumping
      images[id] = self.imageLoader:loadAsset(frame)
    elseif state == "wallSliding" then
      images[id] = self.imageLoader:loadAsset(skin.attacking)
    elseif state == "wallTouching" then
      images[id] = self.imageLoader:loadAsset(skin.running)
    end

    previousTransforms[id]:reset():setTransformation(
      previousXs[id], previousYs[id], 0, directionXs[id] / 16, 1 / 16, 8, 8)

    transforms[id]:reset():setTransformation(
      xs[id], ys[id], 0, directionXs[id] / 16, 1 / 16, 8, 8)
  end
end

return M
