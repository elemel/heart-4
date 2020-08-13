local M = heart.class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)

  self.characterEntities = assert(self.engine.componentEntitySets.character)

  self.boneComponents = assert(self.engine.componentManagers.bone)
  self.characterComponents = assert(self.engine.componentManagers.character)
  self.characterStateComponents = assert(self.engine.componentManagers.characterState)
  self.positionComponents = assert(self.engine.componentManagers.position)
  self.spriteComponents = assert(self.engine.componentManagers.sprite)
  self.transformComponents = assert(self.engine.componentManagers.transform)
  self.velocityComponents = assert(self.engine.componentManagers.velocity)

  self.imageResources = assert(self.engine.resourceLoaders.image)
end

function M:handleEvent(dt)
  local directionXs = self.characterComponents.directionXs

  local previousXs = self.velocityComponents.previousXs
  local previousYs = self.velocityComponents.previousYs

  local xs = self.positionComponents.xs
  local ys = self.positionComponents.ys

  local images = self.spriteComponents.images

  local previousTransforms = self.boneComponents.previousTransforms
  local transforms = self.transformComponents.transforms

  local states = self.characterStateComponents.states
  local images = self.spriteComponents.images

  local characterTypes = self.characterComponents.characterTypes
  local skins = self.characterComponents.skins

  local animationTimes = self.characterComponents.animationTimes

  for id in pairs(self.characterEntities) do
    local characterType = characterTypes[id]
    local skin = skins[characterType]
    local state = states[id]

    if state == "crouching" then
      images[id] = self.imageResources:loadResource(skin.attacking)
    elseif state == "dead" then
      images[id] = self.imageResources:loadResource(skin.dead)
    elseif state == "falling" then
      images[id] = self.imageResources:loadResource(skin.jumping)
    elseif state == "gliding" then
      images[id] = self.imageResources:loadResource(skin.jumping)
    elseif state == "running" then
      animationTimes[id] = animationTimes[id] + 5 * dt
      local frame = animationTimes[id] % 1 < 0.5 and skin.running or skin.jumping
      images[id] = self.imageResources:loadResource(frame)
    elseif state == "sliding" then
      images[id] = self.imageResources:loadResource(skin.attacking)
    elseif state == "sneaking" then
      animationTimes[id] = animationTimes[id] + 2 * dt
      local frame = animationTimes[id] % 1 < 0.5 and skin.running or skin.jumping
      images[id] = self.imageResources:loadResource(frame)
    elseif state == "standing" then
      images[id] = self.imageResources:loadResource(skin.idle)
    elseif state == "walking" then
      animationTimes[id] = animationTimes[id] + 3 * dt
      local frame = animationTimes[id] % 1 < 0.5 and skin.running or skin.jumping
      images[id] = self.imageResources:loadResource(frame)
    elseif state == "wallSliding" then
      images[id] = self.imageResources:loadResource(skin.attacking)
    elseif state == "wallTouching" then
      images[id] = self.imageResources:loadResource(skin.running)
    end

    previousTransforms[id]:reset():setTransformation(
      previousXs[id], previousYs[id], 0, directionXs[id] / 16, 1 / 16, 8, 8)

    transforms[id]:reset():setTransformation(
      xs[id], ys[id], 0, directionXs[id] / 16, 1 / 16, 8, 8)
  end
end

return M
