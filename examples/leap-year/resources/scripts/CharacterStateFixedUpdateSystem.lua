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
  local crouchingAcceleration = self.characterComponents.crouchingAcceleration
  local fallingAcceleration = self.characterComponents.fallingAcceleration

  local xs = self.positionComponents.xs
  local ys = self.positionComponents.ys

  local previousXs = self.velocityComponents.previousXs
  local maxDdx = crouchingAcceleration * dt * dt

  for id in pairs(ids) do
    local dx = xs[id] - previousXs[id]
    local ddx = clamp(-dx, -maxDdx, maxDdx)
    xs[id] = xs[id] + ddx

    ys[id] = ys[id] + fallingAcceleration * dt * dt
  end
end

function CharacterStateFixedUpdateSystem:updateFalling(ids, dt)
  local fallingAcceleration = self.characterComponents.fallingAcceleration
  local ys = self.positionComponents.ys

  for id in pairs(ids) do
    ys[id] = ys[id] + fallingAcceleration * dt * dt
  end
end

function CharacterStateFixedUpdateSystem:updateGliding(ids, dt)
  local fallingAcceleration = self.characterComponents.fallingAcceleration
  local glidingAcceleration = self.characterComponents.glidingAcceleration
  local glidingSpeed = self.characterComponents.glidingSpeed

  local xs = self.positionComponents.xs
  local ys = self.positionComponents.ys

  local previousXs = self.velocityComponents.previousXs
  local inputXs = self.characterComponents.inputXs
  local maxDdx = glidingAcceleration * dt * dt

  for id in pairs(ids) do
    local inputX = inputXs[id]

    local targetVelocityX = inputX * glidingSpeed
    local targetDx = targetVelocityX * dt

    local dx = xs[id] - previousXs[id]
    local ddx = clamp(targetDx - dx, -maxDdx, maxDdx)

    if ddx * inputX > 0 then
      xs[id] = xs[id] + ddx
    end

    ys[id] = ys[id] + fallingAcceleration * dt * dt
  end
end

function CharacterStateFixedUpdateSystem:updateRunning(ids, dt)
  local fallingAcceleration = self.characterComponents.fallingAcceleration
  local runningAcceleration = self.characterComponents.runningAcceleration
  local runningSpeed = self.characterComponents.runningSpeed

  local xs = self.positionComponents.xs
  local ys = self.positionComponents.ys

  local previousXs = self.velocityComponents.previousXs
  local inputXs = self.characterComponents.inputXs
  local maxDdx = runningAcceleration * dt * dt

  for id in pairs(ids) do
    local inputX = inputXs[id]

    local targetVelocityX = inputX * runningSpeed
    local targetDx = targetVelocityX * dt

    local dx = xs[id] - previousXs[id]
    local ddx = clamp(targetDx - dx, -maxDdx, maxDdx)
    xs[id] = xs[id] + ddx

    ys[id] = ys[id] + fallingAcceleration * dt * dt
  end
end

function CharacterStateFixedUpdateSystem:updateSliding(ids, dt)
  local fallingAcceleration = self.characterComponents.fallingAcceleration
  local slidingAcceleration = self.characterComponents.slidingAcceleration

  local xs = self.positionComponents.xs
  local ys = self.positionComponents.ys

  local previousXs = self.velocityComponents.previousXs

  local maxDdx = slidingAcceleration * dt * dt

  for id in pairs(ids) do
    local dx = xs[id] - previousXs[id]
    local ddx = clamp(-dx, -maxDdx, maxDdx)
    xs[id] = xs[id] + ddx

    ys[id] = ys[id] + fallingAcceleration * dt * dt
  end
end

function CharacterStateFixedUpdateSystem:updateSneaking(ids, dt)
  local fallingAcceleration = self.characterComponents.fallingAcceleration
  local sneakingAcceleration = self.characterComponents.sneakingAcceleration
  local sneakingSpeed = self.characterComponents.sneakingSpeed

  local xs = self.positionComponents.xs
  local ys = self.positionComponents.ys

  local previousXs = self.velocityComponents.previousXs
  local inputXs = self.characterComponents.inputXs
  local maxDdx = sneakingAcceleration * dt * dt

  for id in pairs(ids) do
    local inputX = inputXs[id]

    local targetVelocityX = inputX * sneakingSpeed
    local targetDx = targetVelocityX * dt

    local dx = xs[id] - previousXs[id]
    local ddx = clamp(targetDx - dx, -maxDdx, maxDdx)
    xs[id] = xs[id] + ddx

    ys[id] = ys[id] + fallingAcceleration * dt * dt
  end
end

function CharacterStateFixedUpdateSystem:updateStanding(ids, dt)
  local fallingAcceleration = self.characterComponents.fallingAcceleration
  local standingAcceleration = self.characterComponents.standingAcceleration

  local xs = self.positionComponents.xs
  local ys = self.positionComponents.ys

  local previousXs = self.velocityComponents.previousXs
  local maxDdx = standingAcceleration * dt * dt

  for id in pairs(ids) do
    local dx = xs[id] - previousXs[id]
    local ddx = clamp(-dx, -maxDdx, maxDdx)
    xs[id] = xs[id] + ddx

    ys[id] = ys[id] + fallingAcceleration * dt * dt
  end
end

function CharacterStateFixedUpdateSystem:updateWalking(ids, dt)
  local fallingAcceleration = self.characterComponents.fallingAcceleration
  local walkingAcceleration = self.characterComponents.walkingAcceleration
  local walkingSpeed = self.characterComponents.walkingSpeed

  local xs = self.positionComponents.xs
  local ys = self.positionComponents.ys

  local previousXs = self.velocityComponents.previousXs
  local inputXs = self.characterComponents.inputXs
  local maxDdx = walkingAcceleration * dt * dt

  for id in pairs(ids) do
    local inputX = inputXs[id]

    local targetVelocityX = inputX * walkingSpeed
    local targetDx = targetVelocityX * dt

    local dx = xs[id] - previousXs[id]
    local ddx = clamp(targetDx - dx, -maxDdx, maxDdx)
    xs[id] = xs[id] + ddx

    ys[id] = ys[id] + fallingAcceleration * dt * dt
  end
end

function CharacterStateFixedUpdateSystem:updateWallSliding(ids, dt)
  local wallSlidingAcceleration = self.characterComponents.fallingAcceleration
  local wallSlidingSpeed = self.characterComponents.wallSlidingSpeed

  local ys = self.positionComponents.ys
  local previousYs = self.velocityComponents.previousYs
  local maxDdy = wallSlidingAcceleration * dt * dt

  for id in pairs(ids) do
    local targetVelocityY = wallSlidingSpeed
    local targetDy = targetVelocityY * dt

    local dy = ys[id] - previousYs[id]
    local ddy = clamp(targetDy - dy, -maxDdy, maxDdy)
    ys[id] = ys[id] + ddy
  end
end

function CharacterStateFixedUpdateSystem:updateWallTouching(ids, dt)
  local fallingAcceleration = self.characterComponents.fallingAcceleration
  local ys = self.positionComponents.ys

  for id in pairs(ids) do
    ys[id] = ys[id] + fallingAcceleration * dt * dt
  end
end

return CharacterStateFixedUpdateSystem
