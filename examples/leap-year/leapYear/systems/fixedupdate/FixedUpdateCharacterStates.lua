local clamp = heart.math.clamp

local M = heart.class.newClass()

function M:init(game, config)
  self.game = assert(game)

  self.characterEntities = assert(self.game.componentEntitySets.character)
  self.characterManager = assert(self.game.componentManagers.character)

  self.positionManager = assert(self.game.componentManagers.position)
  self.velocityManager = assert(self.game.componentManagers.velocity)
  self.characterStateManager = assert(self.game.componentManagers.characterState)
  self.colliderManager = assert(self.game.componentManagers.collider)

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

function M:__call(dt)
  for state, ids in pairs(self.characterStateManager.stateEntitySets) do
    local handler = self.updateHandlers[state]

    if handler then
      handler(self, ids, dt)
    end
  end
end

function M:updateCrouching(ids, dt)
  local crouchingAcceleration = self.characterManager.crouchingAcceleration
  local fallingAcceleration = self.characterManager.fallingAcceleration

  local xs = self.positionManager.xs
  local ys = self.positionManager.ys

  local previousXs = self.velocityManager.previousXs
  local maxDdx = crouchingAcceleration * dt * dt

  for id in pairs(ids) do
    local dx = xs[id] - previousXs[id]
    local ddx = clamp(-dx, -maxDdx, maxDdx)
    xs[id] = xs[id] + ddx

    ys[id] = ys[id] + fallingAcceleration * dt * dt
  end
end

function M:updateFalling(ids, dt)
  local fallingAcceleration = self.characterManager.fallingAcceleration
  local ys = self.positionManager.ys

  for id in pairs(ids) do
    ys[id] = ys[id] + fallingAcceleration * dt * dt
  end
end

function M:updateGliding(ids, dt)
  local fallingAcceleration = self.characterManager.fallingAcceleration
  local glidingAcceleration = self.characterManager.glidingAcceleration
  local glidingSpeed = self.characterManager.glidingSpeed

  local xs = self.positionManager.xs
  local ys = self.positionManager.ys

  local previousXs = self.velocityManager.previousXs
  local inputXs = self.characterManager.inputXs
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

function M:updateRunning(ids, dt)
  local fallingAcceleration = self.characterManager.fallingAcceleration
  local runningAcceleration = self.characterManager.runningAcceleration
  local runningSpeed = self.characterManager.runningSpeed

  local xs = self.positionManager.xs
  local ys = self.positionManager.ys

  local previousXs = self.velocityManager.previousXs
  local inputXs = self.characterManager.inputXs
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

function M:updateSliding(ids, dt)
  local fallingAcceleration = self.characterManager.fallingAcceleration
  local slidingAcceleration = self.characterManager.slidingAcceleration

  local xs = self.positionManager.xs
  local ys = self.positionManager.ys

  local previousXs = self.velocityManager.previousXs

  local maxDdx = slidingAcceleration * dt * dt

  for id in pairs(ids) do
    local dx = xs[id] - previousXs[id]
    local ddx = clamp(-dx, -maxDdx, maxDdx)
    xs[id] = xs[id] + ddx

    ys[id] = ys[id] + fallingAcceleration * dt * dt
  end
end

function M:updateSneaking(ids, dt)
  local fallingAcceleration = self.characterManager.fallingAcceleration
  local sneakingAcceleration = self.characterManager.sneakingAcceleration
  local sneakingSpeed = self.characterManager.sneakingSpeed

  local xs = self.positionManager.xs
  local ys = self.positionManager.ys

  local previousXs = self.velocityManager.previousXs
  local inputXs = self.characterManager.inputXs
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

function M:updateStanding(ids, dt)
  local fallingAcceleration = self.characterManager.fallingAcceleration
  local standingAcceleration = self.characterManager.standingAcceleration

  local xs = self.positionManager.xs
  local ys = self.positionManager.ys

  local previousXs = self.velocityManager.previousXs
  local maxDdx = standingAcceleration * dt * dt

  for id in pairs(ids) do
    local dx = xs[id] - previousXs[id]
    local ddx = clamp(-dx, -maxDdx, maxDdx)
    xs[id] = xs[id] + ddx

    ys[id] = ys[id] + fallingAcceleration * dt * dt
  end
end

function M:updateWalking(ids, dt)
  local fallingAcceleration = self.characterManager.fallingAcceleration
  local walkingAcceleration = self.characterManager.walkingAcceleration
  local walkingSpeed = self.characterManager.walkingSpeed

  local xs = self.positionManager.xs
  local ys = self.positionManager.ys

  local previousXs = self.velocityManager.previousXs
  local inputXs = self.characterManager.inputXs
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

function M:updateWallSliding(ids, dt)
  local wallSlidingAcceleration = self.characterManager.fallingAcceleration
  local wallSlidingSpeed = self.characterManager.wallSlidingSpeed

  local ys = self.positionManager.ys
  local previousYs = self.velocityManager.previousYs
  local maxDdy = wallSlidingAcceleration * dt * dt

  for id in pairs(ids) do
    local targetVelocityY = wallSlidingSpeed
    local targetDy = targetVelocityY * dt

    local dy = ys[id] - previousYs[id]
    local ddy = clamp(targetDy - dy, -maxDdy, maxDdy)
    ys[id] = ys[id] + ddy
  end
end

function M:updateWallTouching(ids, dt)
  local fallingAcceleration = self.characterManager.fallingAcceleration
  local ys = self.positionManager.ys

  for id in pairs(ids) do
    ys[id] = ys[id] + fallingAcceleration * dt * dt
  end
end

return M
