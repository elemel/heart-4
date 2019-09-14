local clamp = heart.math.clamp

local CharacterStateFixedUpdateSystem = heart.class.newClass()

function CharacterStateFixedUpdateSystem:init(game, config)
  self.game = assert(game)

  self.characterEntities = assert(self.game.componentEntitySets.character)
  self.characterComponents = assert(self.game.componentManagers.character)

  self.positionComponents = assert(self.game.componentManagers.position)
  self.velocityComponents = assert(self.game.componentManagers.velocity)
  self.characterStateComponents = assert(self.game.componentManagers.characterState)
  self.colliderComponents = assert(self.game.componentManagers.collider)

  self.updateHandlers = {
    crouching = self.updateCrouching,
    falling = self.updateFalling,
    gliding = self.updateGliding,
    running = self.updateRunning,
    sliding = self.updateSliding,
    sneaking = self.updateSneaking,
    standing = self.updateStanding,
    walking = self.updateWalking,
    wallSliding = self.updateWallSliding,
    wallTouching = self.updateWallTouching,
  }

  self.crouchingAcceleration = 8
  self.crouchingJumpSpeed = 6

  self.fallingAcceleration = 32

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

function CharacterStateFixedUpdateSystem:fixedUpdate(dt)
  for state, ids in pairs(self.characterStateComponents.stateEntitySets) do
    local handler = self.updateHandlers[state]

    if handler then
      handler(self, ids, dt)
    end
  end
end

function CharacterStateFixedUpdateSystem:updateCrouching(ids, dt)
  local xs = self.positionComponents.xs
  local ys = self.positionComponents.ys

  local previousXs = self.velocityComponents.previousXs
  local maxDdx = self.crouchingAcceleration * dt * dt

  for id in pairs(ids) do
    local dx = xs[id] - previousXs[id]
    local ddx = clamp(-dx, -maxDdx, maxDdx)
    xs[id] = xs[id] + ddx

    ys[id] = ys[id] + self.fallingAcceleration * dt * dt
  end
end

function CharacterStateFixedUpdateSystem:updateFalling(ids, dt)
  local ys = self.positionComponents.ys

  for id in pairs(ids) do
    ys[id] = ys[id] + self.fallingAcceleration * dt * dt
  end
end

function CharacterStateFixedUpdateSystem:updateGliding(ids, dt)
  local xs = self.positionComponents.xs
  local ys = self.positionComponents.ys

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

    ys[id] = ys[id] + self.fallingAcceleration * dt * dt
  end
end

function CharacterStateFixedUpdateSystem:updateRunning(ids, dt)
  local xs = self.positionComponents.xs
  local ys = self.positionComponents.ys

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

    ys[id] = ys[id] + self.fallingAcceleration * dt * dt
  end
end

function CharacterStateFixedUpdateSystem:updateSliding(ids, dt)
  local xs = self.positionComponents.xs
  local ys = self.positionComponents.ys

  local previousXs = self.velocityComponents.previousXs

  local maxDdx = self.slidingAcceleration * dt * dt

  for id in pairs(ids) do
    local dx = xs[id] - previousXs[id]
    local ddx = clamp(-dx, -maxDdx, maxDdx)
    xs[id] = xs[id] + ddx

    ys[id] = ys[id] + self.fallingAcceleration * dt * dt
  end
end

function CharacterStateFixedUpdateSystem:updateSneaking(ids, dt)
  local xs = self.positionComponents.xs
  local ys = self.positionComponents.ys

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

    ys[id] = ys[id] + self.fallingAcceleration * dt * dt
  end
end

function CharacterStateFixedUpdateSystem:updateStanding(ids, dt)
  local xs = self.positionComponents.xs
  local ys = self.positionComponents.ys

  local previousXs = self.velocityComponents.previousXs
  local maxDdx = self.standingAcceleration * dt * dt

  for id in pairs(ids) do
    local dx = xs[id] - previousXs[id]
    local ddx = clamp(-dx, -maxDdx, maxDdx)
    xs[id] = xs[id] + ddx

    ys[id] = ys[id] + self.fallingAcceleration * dt * dt
  end
end

function CharacterStateFixedUpdateSystem:updateWalking(ids, dt)
  local xs = self.positionComponents.xs
  local ys = self.positionComponents.ys

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

    ys[id] = ys[id] + self.fallingAcceleration * dt * dt
  end
end

function CharacterStateFixedUpdateSystem:updateWallSliding(ids, dt)
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

function CharacterStateFixedUpdateSystem:updateWallTouching(ids, dt)
  local ys = self.positionComponents.ys

  for id in pairs(ids) do
    ys[id] = ys[id] + self.fallingAcceleration * dt * dt
  end
end

return CharacterStateFixedUpdateSystem
