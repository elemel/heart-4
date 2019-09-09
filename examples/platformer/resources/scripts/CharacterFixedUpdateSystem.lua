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
    gliding = self.transitionGliding,
    running = self.transitionRunning,
    sliding = self.transitionSliding,
    sneaking = self.transitionSneaking,
    standing = self.transitionStanding,
    walking = self.transitionWalking,
  }

  self.updateHandlers = {
    crouching = self.updateCrouching,
    gliding = self.updateGliding,
    running = self.updateRunning,
    sliding = self.updateSliding,
    sneaking = self.updateSneaking,
    standing = self.updateStanding,
    walking = self.updateWalking,
  }

  self.crouchingAcceleration = 6
  self.crouchingJumpSpeed = 6

  self.glidingSpeed = 3
  self.glidingAcceleration = 8

  self.slidingAcceleration = 3
  self.slidingJumpSpeed = 10

  self.sneakingAcceleration = 6
  self.sneakingSpeed = 1.5
  self.sneakingJumpSpeed = 10

  self.standingAcceleration = 12
  self.standingJumpSpeed = 10

  self.runningAcceleration = 18
  self.runningJumpSpeed = 15
  self.runningSpeed = 4.5

  self.walkingJumpSpeed = 13
  self.walkingSpeed = 3
  self.walkingAcceleration = 12
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
  local ys = self.positionComponents.ys
  local directionXs = self.characterComponents.directionXs
  local animationTimes = self.characterComponents.animationTimes

  local inputXs = self.characterComponents.inputXs
  local inputYs = self.characterComponents.inputYs

  local jumpInputs = self.characterComponents.jumpInputs

  for id in pairs(ids) do
    repeat
      local constraintMap = constraintMaps[id]

      if not constraintMap.down then
        newStates[id] = "falling"
        break
      end

      if inputYs[id] ~= 1 then
        newStates[id] = "standing"
        break
      end

      if inputXs[id] == -directionXs[id] then
        directionXs[id] = -directionXs[id]
        break
      end

      if inputXs[id] == directionXs[id] then
        newStates[id] = "sneaking"
        animationTimes[id] = 0
        break
      end

      if jumpInputs[id] then
        ys[id] = ys[id] - self.crouchingJumpSpeed * dt
        newStates[id] = "falling"
        break
      end
    until true
  end
end

function CharacterFixedUpdateSystem:transitionGliding(ids, dt, newStates)
  local constraintMaps = self.colliderComponents.constraintMaps
  local directionXs = self.characterComponents.directionXs
  local animationTimes = self.characterComponents.animationTimes

  local inputXs = self.characterComponents.inputXs
  local runInputs = self.characterComponents.runInputs

  for id in pairs(ids) do
    repeat
      local constraintMap = constraintMaps[id]

      if constraintMap.down then
        newStates[id] = runInputs[id] and "running" or "walking"
        animationTimes[id] = 0
        break
      end

      if inputXs[id] ~= directionXs[id] then
        newStates[id] = "falling"
        break
      end

    until true
  end
end

function CharacterFixedUpdateSystem:transitionFalling(ids, dt, newStates)
  local constraintMaps = self.colliderComponents.constraintMaps
  local directionXs = self.characterComponents.directionXs
  local inputXs = self.characterComponents.inputXs

  for id in pairs(ids) do
    repeat
      local constraintMap = constraintMaps[id]

      if constraintMap.down then
        newStates[id] = "standing"
        break
      end

      if inputXs[id] == -directionXs[id] then
        directionXs[id] = -directionXs[id]
        break
      end

      if inputXs[id] == directionXs[id] then
        newStates[id] = "gliding"
        break
      end
    until true
  end
end

function CharacterFixedUpdateSystem:transitionRunning(ids, dt, newStates)
  local constraintMaps = self.colliderComponents.constraintMaps
  local ys = self.positionComponents.ys
  local directionXs = self.characterComponents.directionXs

  local inputXs = self.characterComponents.inputXs
  local inputYs = self.characterComponents.inputYs

  local runInputs = self.characterComponents.runInputs
  local jumpInputs = self.characterComponents.jumpInputs

  for id in pairs(ids) do
    repeat
      local constraintMap = constraintMaps[id]

      if not constraintMap.down then
        newStates[id] = "gliding"
        break
      end

      if inputYs[id] == 1 then
        newStates[id] = "sliding"
        break
      end

      if not runInputs[id] then
        newStates[id] = "walking"
        break
      end

      if inputXs[id] ~= directionXs[id] then
        newStates[id] = "walking"
        break
      end

      if jumpInputs[id] then
        ys[id] = ys[id] - self.runningJumpSpeed * dt
        newStates[id] = "gliding"
        break
      end
    until true
  end
end

function CharacterFixedUpdateSystem:transitionSliding(ids, dt, newStates)
  local constraintMaps = self.colliderComponents.constraintMaps
  local ys = self.positionComponents.ys
  local directionXs = self.characterComponents.directionXs
  local animationTimes = self.characterComponents.animationTimes

  local inputXs = self.characterComponents.inputXs
  local inputYs = self.characterComponents.inputYs

  local jumpInputs = self.characterComponents.jumpInputs

  for id in pairs(ids) do
    repeat
      local constraintMap = constraintMaps[id]

      if not constraintMap.down then
        newStates[id] = "gliding"
        break
      end

      if inputYs[id] ~= 1 then
        newStates[id] = "running"
        animationTimes[id] = 0
        break
      end

      if inputXs[id] ~= directionXs[id] then
        newStates[id] = "crouching"
        break
      end

      if jumpInputs[id] then
        ys[id] = ys[id] - self.slidingJumpSpeed * dt
        newStates[id] = "gliding"
        break
      end
    until true
  end
end

function CharacterFixedUpdateSystem:transitionSneaking(ids, dt, newStates)
  local constraintMaps = self.colliderComponents.constraintMaps
  local ys = self.positionComponents.ys
  local directionXs = self.characterComponents.directionXs

  local inputXs = self.characterComponents.inputXs
  local inputYs = self.characterComponents.inputYs

  local jumpInputs = self.characterComponents.jumpInputs

  for id in pairs(ids) do
    repeat
      local constraintMap = constraintMaps[id]

      if not constraintMap.down then
        newStates[id] = "gliding"
        break
      end

      if inputYs[id] ~= 1 then
        newStates[id] = "walking"
        break
      end

      if inputXs[id] ~= directionXs[id] then
        newStates[id] = "crouching"
        break
      end

      if jumpInputs[id] then
        ys[id] = ys[id] - self.sneakingJumpSpeed * dt
        newStates[id] = "gliding"
        break
      end
    until true
  end
end

function CharacterFixedUpdateSystem:transitionStanding(ids, dt, newStates)
  local constraintMaps = self.colliderComponents.constraintMaps
  local animationTimes = self.characterComponents.animationTimes
  local ys = self.positionComponents.ys
  local directionXs = self.characterComponents.directionXs

  local inputXs = self.characterComponents.inputXs
  local inputYs = self.characterComponents.inputYs

  local jumpInputs = self.characterComponents.jumpInputs

  for id in pairs(ids) do
    repeat
      local constraintMap = constraintMaps[id]

      if not constraintMap.down then
        newStates[id] = "falling"
        break
      end

      if inputYs[id] == 1 then
        newStates[id] = "crouching"
        break
      end

      if inputXs[id] == -directionXs[id] then
        directionXs[id] = -directionXs[id]
        break
      end

      if inputXs[id] == directionXs[id] then
        newStates[id] = "walking"
        animationTimes[id] = 0
        break
      end

      if jumpInputs[id] then
        ys[id] = ys[id] - self.standingJumpSpeed * dt
        newStates[id] = "falling"
        break
      end
    until true
  end
end

function CharacterFixedUpdateSystem:transitionWalking(ids, dt, newStates)
  local constraintMaps = self.colliderComponents.constraintMaps
  local ys = self.positionComponents.ys
  local directionXs = self.characterComponents.directionXs

  local inputXs = self.characterComponents.inputXs
  local inputYs = self.characterComponents.inputYs

  local runInputs = self.characterComponents.runInputs
  local jumpInputs = self.characterComponents.jumpInputs

  for id in pairs(ids) do
    repeat
      local constraintMap = constraintMaps[id]

      if not constraintMap.down then
        newStates[id] = "gliding"
        break
      end

      if inputYs[id] == 1 then
        newStates[id] = "sneaking"
        break
      end

      if inputXs[id] ~= directionXs[id] then
        newStates[id] = "standing"
        break
      end

      if runInputs[id] then
        newStates[id] = "running"
        break
      end

      if jumpInputs[id] then
        ys[id] = ys[id] - self.walkingJumpSpeed * dt
        newStates[id] = "gliding"
        break
      end
    until true
  end
end

function CharacterFixedUpdateSystem:updateCrouching(ids, dt)
  local xs = self.positionComponents.xs
  local previousXs = self.velocityComponents.previousXs

  local maxDdx = self.crouchingAcceleration * dt * dt

  for id in pairs(ids) do
    local dx = xs[id] - previousXs[id]
    local ddx = clamp(-dx, -maxDdx, maxDdx)
    xs[id] = xs[id] + ddx
  end
end

function CharacterFixedUpdateSystem:updateGliding(ids, dt)
  local xs = self.positionComponents.xs
  local previousXs = self.velocityComponents.previousXs
  local inputXs = self.characterComponents.inputXs
  local maxDdx = self.glidingAcceleration * dt * dt

  for id in pairs(ids) do
    local inputX = inputXs[id]

    local targetVelocityX = inputX * self.glidingSpeed
    local targetDx = targetVelocityX * dt

    local dx = xs[id] - previousXs[id]
    local ddx = clamp(targetDx - dx, -maxDdx, maxDdx)

    if ddx * inputX > 0 then
      xs[id] = xs[id] + ddx
    end
  end
end

function CharacterFixedUpdateSystem:updateRunning(ids, dt)
  local xs = self.positionComponents.xs
  local previousXs = self.velocityComponents.previousXs
  local inputXs = self.characterComponents.inputXs
  local maxDdx = self.runningAcceleration * dt * dt

  for id in pairs(ids) do
    local inputX = inputXs[id]

    local targetVelocityX = inputX * self.runningSpeed
    local targetDx = targetVelocityX * dt

    local dx = xs[id] - previousXs[id]
    local ddx = clamp(targetDx - dx, -maxDdx, maxDdx)
    xs[id] = xs[id] + ddx
  end
end

function CharacterFixedUpdateSystem:updateSliding(ids, dt)
  local xs = self.positionComponents.xs
  local previousXs = self.velocityComponents.previousXs

  local maxDdx = self.slidingAcceleration * dt * dt

  for id in pairs(ids) do
    local dx = xs[id] - previousXs[id]
    local ddx = clamp(-dx, -maxDdx, maxDdx)
    xs[id] = xs[id] + ddx
  end
end

function CharacterFixedUpdateSystem:updateSneaking(ids, dt)
  local xs = self.positionComponents.xs
  local previousXs = self.velocityComponents.previousXs
  local inputXs = self.characterComponents.inputXs
  local maxDdx = self.sneakingAcceleration * dt * dt

  for id in pairs(ids) do
    local inputX = inputXs[id]

    local targetVelocityX = inputX * self.sneakingSpeed
    local targetDx = targetVelocityX * dt

    local dx = xs[id] - previousXs[id]
    local ddx = clamp(targetDx - dx, -maxDdx, maxDdx)
    xs[id] = xs[id] + ddx
  end
end

function CharacterFixedUpdateSystem:updateStanding(ids, dt)
  local xs = self.positionComponents.xs
  local previousXs = self.velocityComponents.previousXs
  local maxDdx = self.standingAcceleration * dt * dt

  for id in pairs(ids) do
    local dx = xs[id] - previousXs[id]
    local ddx = clamp(-dx, -maxDdx, maxDdx)
    xs[id] = xs[id] + ddx
  end
end

function CharacterFixedUpdateSystem:updateWalking(ids, dt)
  local xs = self.positionComponents.xs
  local previousXs = self.velocityComponents.previousXs
  local inputXs = self.characterComponents.inputXs
  local maxDdx = self.walkingAcceleration * dt * dt

  for id in pairs(ids) do
    local inputX = inputXs[id]

    local targetVelocityX = inputX * self.walkingSpeed
    local targetDx = targetVelocityX * dt

    local dx = xs[id] - previousXs[id]
    local ddx = clamp(targetDx - dx, -maxDdx, maxDdx)
    xs[id] = xs[id] + ddx
  end
end

return CharacterFixedUpdateSystem
