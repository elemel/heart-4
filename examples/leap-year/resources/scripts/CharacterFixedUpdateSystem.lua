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
  self.gravityComponents = assert(self.game.componentManagers.gravity)

  self.transitionHandlers = {
    crouching = self.transitionCrouching,
    falling = self.transitionFalling,
    gliding = self.transitionGliding,
    running = self.transitionRunning,
    sliding = self.transitionSliding,
    sneaking = self.transitionSneaking,
    standing = self.transitionStanding,
    walking = self.transitionWalking,
    wallSliding = self.transitionWallSliding,
  }

  self.updateHandlers = {
    crouching = self.updateCrouching,
    gliding = self.updateGliding,
    running = self.updateRunning,
    sliding = self.updateSliding,
    sneaking = self.updateSneaking,
    standing = self.updateStanding,
    walking = self.updateWalking,
    wallSliding = self.updateWallSliding,
  }

  self.crouchingAcceleration = 8
  self.crouchingJumpSpeed = 6

  self.fallAcceleration = 32

  self.glidingSpeed = 3
  self.glidingAcceleration = 6

  self.slidingAcceleration = 4
  self.slidingJumpSpeed = 10

  self.sneakingAcceleration = 8
  self.sneakingSpeed = 2
  self.sneakingJumpSpeed = 10

  self.standingAcceleration = 12
  self.standingJumpSpeed = 10

  self.runningAcceleration = 20
  self.runningJumpSpeed = 15
  self.runningSpeed = 5

  self.walkingJumpSpeed = 13
  self.walkingSpeed = 3
  self.walkingAcceleration = 12

  self.wallSlidingJumpSpeedX = 5
  self.wallSlidingJumpSpeedY = 13
  self.wallSlidingAcceleration = 32
  self.wallSlidingSpeed = 5
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

  local oldJumpInputs = self.characterComponents.oldJumpInputs
  local jumpInputs = self.characterComponents.jumpInputs

  for id in pairs(ids) do
    repeat
      local constraintMap = constraintMaps[id]

      if not constraintMap.down then
        newStates[id] = "falling"
        break
      end

      if jumpInputs[id] and not oldJumpInputs[id] then
        ys[id] = ys[id] - self.crouchingJumpSpeed * dt
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
    until true
  end
end

function CharacterFixedUpdateSystem:transitionGliding(ids, dt, newStates)
  local constraintMaps = self.colliderComponents.constraintMaps
  local directionXs = self.characterComponents.directionXs
  local animationTimes = self.characterComponents.animationTimes

  local inputXs = self.characterComponents.inputXs
  local runInputs = self.characterComponents.runInputs

  local gravityXs = self.gravityComponents.gravityXs
  local gravityYs = self.gravityComponents.gravityYs

  for id in pairs(ids) do
    repeat
      local constraintMap = constraintMaps[id]

      if constraintMap.down then
        newStates[id] = runInputs[id] and "running" or "walking"
        animationTimes[id] = 0
        break
      end

      if constraintMap.left and not constraintMap.right and directionXs[id] == -1 then
        newStates[id] = "wallSliding"

        gravityXs[id] = -self.fallAcceleration
        gravityYs[id] = 0

        break
      end

      if not constraintMap.left and constraintMap.right and directionXs[id] == 1 then
        newStates[id] = "wallSliding"

        gravityXs[id] = self.fallAcceleration
        gravityYs[id] = 0

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

  local gravityXs = self.gravityComponents.gravityXs
  local gravityYs = self.gravityComponents.gravityYs

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

      if constraintMap.left and not constraintMap.right and directionXs[id] == -1 then
        newStates[id] = "wallSliding"

        gravityXs[id] = -self.fallAcceleration
        gravityYs[id] = 0

        break
      end

      if not constraintMap.left and constraintMap.right and directionXs[id] == 1 then
        newStates[id] = "wallSliding"

        gravityXs[id] = self.fallAcceleration
        gravityYs[id] = 0

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

  local oldJumpInputs = self.characterComponents.oldJumpInputs
  local jumpInputs = self.characterComponents.jumpInputs

  for id in pairs(ids) do
    repeat
      local constraintMap = constraintMaps[id]

      if not constraintMap.down then
        newStates[id] = "gliding"
        break
      end

      if jumpInputs[id] and not oldJumpInputs[id] then
        ys[id] = ys[id] - self.runningJumpSpeed * dt
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

  local oldJumpInputs = self.characterComponents.oldJumpInputs
  local jumpInputs = self.characterComponents.jumpInputs

  for id in pairs(ids) do
    repeat
      local constraintMap = constraintMaps[id]

      if not constraintMap.down then
        newStates[id] = "gliding"
        break
      end

      if jumpInputs[id] and not oldJumpInputs[id] then
        ys[id] = ys[id] - self.slidingJumpSpeed * dt
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
    until true
  end
end

function CharacterFixedUpdateSystem:transitionSneaking(ids, dt, newStates)
  local constraintMaps = self.colliderComponents.constraintMaps
  local ys = self.positionComponents.ys
  local directionXs = self.characterComponents.directionXs

  local inputXs = self.characterComponents.inputXs
  local inputYs = self.characterComponents.inputYs

  local oldJumpInputs = self.characterComponents.oldJumpInputs
  local jumpInputs = self.characterComponents.jumpInputs

  for id in pairs(ids) do
    repeat
      local constraintMap = constraintMaps[id]

      if not constraintMap.down then
        newStates[id] = "gliding"
        break
      end

      if jumpInputs[id] and not oldJumpInputs[id] then
        ys[id] = ys[id] - self.sneakingJumpSpeed * dt
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

  local oldJumpInputs = self.characterComponents.oldJumpInputs
  local jumpInputs = self.characterComponents.jumpInputs

  for id in pairs(ids) do
    repeat
      local constraintMap = constraintMaps[id]

      if not constraintMap.down then
        newStates[id] = "falling"
        break
      end

      if jumpInputs[id] and not oldJumpInputs[id] then
        ys[id] = ys[id] - self.standingJumpSpeed * dt
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

  local oldJumpInputs = self.characterComponents.oldJumpInputs
  local jumpInputs = self.characterComponents.jumpInputs

  for id in pairs(ids) do
    repeat
      local constraintMap = constraintMaps[id]

      if not constraintMap.down then
        newStates[id] = "gliding"
        break
      end

      if jumpInputs[id] and not oldJumpInputs[id] then
        ys[id] = ys[id] - self.walkingJumpSpeed * dt
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
    until true
  end
end

function CharacterFixedUpdateSystem:transitionWallSliding(ids, dt, newStates)
  local constraintMaps = self.colliderComponents.constraintMaps
  local directionXs = self.characterComponents.directionXs
  local inputXs = self.characterComponents.inputXs

  local oldJumpInputs = self.characterComponents.oldJumpInputs
  local jumpInputs = self.characterComponents.jumpInputs

  local xs = self.positionComponents.xs
  local ys = self.positionComponents.ys

  local previousYs = self.velocityComponents.previousYs

  local gravityXs = self.gravityComponents.gravityXs
  local gravityYs = self.gravityComponents.gravityYs

  for id in pairs(ids) do
    repeat
      local constraintMap = constraintMaps[id]

      if directionXs[id] == -1 and not constraintMap.left then
        newStates[id] = "falling"

        gravityXs[id] = 0
        gravityYs[id] = self.fallAcceleration

        break
      end

      if directionXs[id] == 1 and not constraintMap.right then
        newStates[id] = "falling"

        gravityXs[id] = 0
        gravityYs[id] = self.fallAcceleration

        break
      end

      if jumpInputs[id] and not oldJumpInputs[id] then
        newStates[id] = "falling"

        directionXs[id] = -directionXs[id]

        xs[id] = xs[id] + directionXs[id] * self.wallSlidingJumpSpeedX * dt
        ys[id] = previousYs[id] - self.wallSlidingJumpSpeedY * dt

        gravityXs[id] = 0
        gravityYs[id] = self.fallAcceleration

        break
      end

      if inputXs[id] == -directionXs[id] then
        newStates[id] = "gliding"
        directionXs[id] = -directionXs[id]

        gravityXs[id] = 0
        gravityYs[id] = self.fallAcceleration

        break
      end

      if constraintMap.down then
        newStates[id] = "standing"

        gravityXs[id] = 0
        gravityYs[id] = self.fallAcceleration

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

function CharacterFixedUpdateSystem:updateWallSliding(ids, dt)
  local ys = self.positionComponents.ys
  local previousYs = self.velocityComponents.previousYs
  local maxDdy = self.wallSlidingAcceleration * dt * dt

  for id in pairs(ids) do
    local targetVelocityY = self.wallSlidingSpeed
    local targetDy = targetVelocityY * dt

    local dy = ys[id] - previousYs[id]
    local ddy = clamp(targetDy - dy, -maxDdy, maxDdy)
    ys[id] = ys[id] + ddy
  end
end

return CharacterFixedUpdateSystem