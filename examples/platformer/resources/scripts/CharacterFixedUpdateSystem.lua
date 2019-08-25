local clamp = heart.math.clamp

local CharacterFixedUpdateSystem = heart.class.newClass()

function CharacterFixedUpdateSystem:init(game, config)
  self.game = assert(game)

  self.characterEntities = assert(self.game.componentEntitySets.character)
  self.characterComponents = assert(self.game.componentManagers.character)

  self.positionComponents = assert(self.game.componentManagers.position)
  self.velocityComponents = assert(self.game.componentManagers.velocity)
  self.characterStateComponents = assert(self.game.componentManagers.characterState)
  self.colliderComponents = assert(self.game.componentManagers.collider)

  self.transitionHandlers = {
    crouching = self.transitionCrouching,
    falling = self.transitionFalling,
    standing = self.transitionStanding,
    walking = self.transitionWalking,
  }

  self.updateHandlers = {
    crouching = self.updateCrouching,
    standing = self.updateStanding,
    walking = self.updateWalking,
  }
end

function CharacterFixedUpdateSystem:fixedUpdate(dt)
  local newStates = {}

  for state, ids in pairs(self.characterStateComponents.stateEntitySets) do
    local handler = self.transitionHandlers[state]

    if handler then
      handler(self, ids, dt, newStates)
    end
  end

  for id, state in pairs(newStates) do
    self.characterStateComponents:setState(id, state)
  end

  for state, ids in pairs(self.characterStateComponents.stateEntitySets) do
    local handler = self.updateHandlers[state]

    if handler then
      handler(self, ids, dt)
    end
  end
end

function CharacterFixedUpdateSystem:transitionCrouching(ids, dt, newStates)
  local constraintMaps = self.colliderComponents.constraintMaps

  for id in pairs(ids) do
    repeat
      local constraintMap = constraintMaps[id]

      if not constraintMap.down then
        newStates[id] = "falling"
        break
      end

      local upInput = love.keyboard.isDown("w")
      local downInput = love.keyboard.isDown("s")

      local inputY = (downInput and 1 or 0) - (upInput and 1 or 0)

      if inputY ~= 1 then
        newStates[id] = "standing"
        break
      end
    until true
  end
end

function CharacterFixedUpdateSystem:transitionFalling(ids, dt, newStates)
  local constraintMaps = self.colliderComponents.constraintMaps

  for id in pairs(ids) do
    repeat
      local constraintMap = constraintMaps[id]

      if constraintMap.down then
        newStates[id] = "standing"
        break
      end
    until true
  end
end

function CharacterFixedUpdateSystem:transitionStanding(ids, dt, newStates)
  local constraintMaps = self.colliderComponents.constraintMaps
  local ys = self.positionComponents.ys

  for id in pairs(ids) do
    repeat
      local constraintMap = constraintMaps[id]

      if not constraintMap.down then
        newStates[id] = "falling"
        break
      end

      local upInput = love.keyboard.isDown("w")
      local downInput = love.keyboard.isDown("s")

      local inputY = (downInput and 1 or 0) - (upInput and 1 or 0)

      if inputY == 1 then
        newStates[id] = "crouching"
        break
      end

      local jumpInput = love.keyboard.isDown("space")

      if jumpInput then
        ys[id] = ys[id] - 8 * dt
        newStates[id] = "falling"
        break
      end

      local leftInput = love.keyboard.isDown("a")
      local rightInput = love.keyboard.isDown("d")

      local inputX = (rightInput and 1 or 0) - (leftInput and 1 or 0)

      if inputX ~= 0 then
        newStates[id] = "walking"
        break
      end
    until true
  end
end

function CharacterFixedUpdateSystem:transitionWalking(ids, dt, newStates)
  local constraintMaps = self.colliderComponents.constraintMaps
  local ys = self.positionComponents.ys

  for id in pairs(ids) do
    repeat
      local constraintMap = constraintMaps[id]

      if not constraintMap.down then
        newStates[id] = "falling"
        break
      end

      local upInput = love.keyboard.isDown("w")
      local downInput = love.keyboard.isDown("s")

      local inputY = (downInput and 1 or 0) - (upInput and 1 or 0)

      if inputY == 1 then
        newStates[id] = "crouching"
        break
      end

      local jumpInput = love.keyboard.isDown("space")

      if jumpInput then
        ys[id] = ys[id] - 8 * dt
        newStates[id] = "falling"
        break
      end

      local leftInput = love.keyboard.isDown("a")
      local rightInput = love.keyboard.isDown("d")

      local inputX = (rightInput and 1 or 0) - (leftInput and 1 or 0)

      if inputX == 0 then
        newStates[id] = "standing"
        break
      end
    until true
  end
end

function CharacterFixedUpdateSystem:updateCrouching(ids, dt)
  local xs = self.positionComponents.xs
  local previousXs = self.velocityComponents.previousXs

  local maxAccelerationX = 2
  local maxDdx = maxAccelerationX * dt * dt

  for id in pairs(ids) do
    local dx = xs[id] - previousXs[id]
    local ddx = clamp(-dx, -maxDdx, maxDdx)
    xs[id] = xs[id] + ddx
  end
end

function CharacterFixedUpdateSystem:updateStanding(ids, dt)
  local xs = self.positionComponents.xs
  local previousXs = self.velocityComponents.previousXs

  local maxAccelerationX = 8
  local maxDdx = maxAccelerationX * dt * dt

  for id in pairs(ids) do
    local dx = xs[id] - previousXs[id]
    local ddx = clamp(-dx, -maxDdx, maxDdx)
    xs[id] = xs[id] + ddx
  end
end

function CharacterFixedUpdateSystem:updateWalking(ids, dt)
  local directionXs = self.characterComponents.directionXs

  local xs = self.positionComponents.xs
  local previousXs = self.velocityComponents.previousXs

  local leftInput = love.keyboard.isDown("a")
  local rightInput = love.keyboard.isDown("d")

  local inputX = (rightInput and 1 or 0) - (leftInput and 1 or 0)
  local maxAccelerationX = 8
  local maxVelocityX = 2
  local targetVelocityX = inputX * maxVelocityX
  local targetDx = targetVelocityX * dt
  local maxDdx = maxAccelerationX * dt * dt

  for id in pairs(ids) do
    local dx = xs[id] - previousXs[id]
    local ddx = clamp(targetDx - dx, -maxDdx, maxDdx)
    xs[id] = xs[id] + ddx

    if inputX ~= 0 then
      directionXs[id] = inputX
    end
  end
end

return CharacterFixedUpdateSystem
