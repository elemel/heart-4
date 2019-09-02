local CharacterAnimationFixedUpdateSystem = heart.class.newClass()

function CharacterAnimationFixedUpdateSystem:init(game, config)
  self.game = assert(game)

  self.characterEntities = assert(self.game.componentEntitySets.character)
  self.characterComponents = assert(self.game.componentManagers.character)

  self.positionComponents = assert(self.game.componentManagers.position)
  self.velocityComponents = assert(self.game.componentManagers.velocity)
  self.spriteComponents = assert(self.game.componentManagers.sprite)
  self.characterStateComponents = assert(self.game.componentManagers.characterState)

  self.imageResources = assert(self.game.resourceLoaders.image)
end

function CharacterAnimationFixedUpdateSystem:fixedUpdate(dt)
  local directionXs = self.characterComponents.directionXs

  local previousXs = self.velocityComponents.previousXs
  local previousYs = self.velocityComponents.previousYs

  local xs = self.positionComponents.xs
  local ys = self.positionComponents.ys

  local images = self.spriteComponents.images

  local previousTransforms = self.spriteComponents.previousTransforms
  local transforms = self.spriteComponents.transforms

  local states = self.characterStateComponents.states
  local images = self.spriteComponents.images

  local characterTypes = self.characterComponents.characterTypes
  local skins = self.characterComponents.skins

  local animationTimes = self.characterComponents.animationTimes

  for id in pairs(self.characterEntities) do
    animationTimes[id] = animationTimes[id] + dt

    local characterType = characterTypes[id]
    local skin = skins[characterType]
    local state = states[id]

    if state == "crouching" then
      images[id] = self.imageResources:loadResource(skin.attacking)
    elseif state == "dead" then
      images[id] = self.imageResources:loadResource(skin.dead)
    elseif state == "falling" then
      images[id] = self.imageResources:loadResource(skin.jumping)
    elseif state == "running" then
      local frame = animationTimes[id] % 0.3 < 0.15 and skin.running or skin.jumping
      images[id] = self.imageResources:loadResource(frame)
    elseif state == "sliding" then
      images[id] = self.imageResources:loadResource(skin.attacking)
    elseif state == "standing" then
      images[id] = self.imageResources:loadResource(skin.idle)
    elseif state == "walking" then
      local frame = animationTimes[id] % 0.5 < 0.25 and skin.running or skin.jumping
      images[id] = self.imageResources:loadResource(frame)
    end

    previousTransforms[id]:reset():setTransformation(
      previousXs[id], previousYs[id], 0, directionXs[id] / 16, 1 / 16, 8, 8)

    transforms[id]:reset():setTransformation(
      xs[id], ys[id], 0, directionXs[id] / 16, 1 / 16, 8, 8)
  end
end

return CharacterAnimationFixedUpdateSystem