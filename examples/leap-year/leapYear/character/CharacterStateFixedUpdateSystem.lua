local clamp = heart.math.clamp

local M = heart.class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)

  self.characterEntities = assert(self.engine.componentEntitySets.character)

  self.characterComponents = assert(self.engine.componentManagers.character)
  self.characterStateComponents = assert(self.engine.componentManagers.characterState)
  self.positionComponents = assert(self.engine.componentManagers.position)
  self.velocityComponents = assert(self.engine.componentManagers.velocity)

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

function M:handleEvent(dt)
  for state, ids in pairs(self.characterStateComponents.stateEntitySets) do
    local handler = self.updateHandlers[state]

    if handler then
      handler(self, ids, dt)
    end
  end
end

function M:updateCrouching(ids, dt)
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

function M:updateFalling(ids, dt)
  local fallingAcceleration = self.characterComponents.fallingAcceleration
  local ys = self.positionComponents.ys

  for id in pairs(ids) do
    ys[id] = ys[id] + fallingAcceleration * dt * dt
  end
end

function M:updateGliding(ids, dt)
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

function M:updateRunning(ids, dt)
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

function M:updateSliding(ids, dt)
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

function M:updateSneaking(ids, dt)
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

function M:updateStanding(ids, dt)
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

function M:updateWalking(ids, dt)
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

function M:updateWallSliding(ids, dt)
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

function M:updateWallTouching(ids, dt)
  local fallingAcceleration = self.characterComponents.fallingAcceleration
  local ys = self.positionComponents.ys

  for id in pairs(ids) do
    ys[id] = ys[id] + fallingAcceleration * dt * dt
  end
end

return M
