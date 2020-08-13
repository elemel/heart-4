local clamp = heart.math.clamp

local M = heart.class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)

  self.characterEntities = assert(self.engine.componentEntitySets.character)

  self.characterComponents = assert(self.engine.componentManagers.character)
  self.characterStateComponents = assert(self.engine.componentManagers.characterState)
  self.positionComponents = assert(self.engine.componentManagers.position)
  self.velocityComponents = assert(self.engine.componentManagers.velocity)

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
    wallTouching = self.transitionWallTouching,
  }
end

function M:handleEvent(dt)
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
end

function M:transitionCrouching(ids, dt, newStates)
  local crouchingJumpSpeed = self.characterComponents.crouchingJumpSpeed
  local directionXs = self.characterComponents.directionXs
  local animationTimes = self.characterComponents.animationTimes

  local inputXs = self.characterComponents.inputXs
  local inputYs = self.characterComponents.inputYs

  local oldJumpInputs = self.characterComponents.oldJumpInputs
  local jumpInputs = self.characterComponents.jumpInputs

  local ys = self.positionComponents.ys
  local previousYs = self.velocityComponents.previousYs

  for id in pairs(ids) do
    repeat
      if jumpInputs[id] and not oldJumpInputs[id] then
        ys[id] = previousYs[id] - crouchingJumpSpeed * dt
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

function M:transitionGliding(ids, dt, newStates)
  local directionXs = self.characterComponents.directionXs
  local inputXs = self.characterComponents.inputXs

  for id in pairs(ids) do
    repeat
      if inputXs[id] ~= directionXs[id] then
        newStates[id] = "falling"
        break
      end

    until true
  end
end

function M:transitionFalling(ids, dt, newStates)
  local directionXs = self.characterComponents.directionXs
  local inputXs = self.characterComponents.inputXs

  for id in pairs(ids) do
    repeat
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

function M:transitionRunning(ids, dt, newStates)
  local runningJumpSpeed = self.characterComponents.runningJumpSpeed
  local directionXs = self.characterComponents.directionXs

  local inputXs = self.characterComponents.inputXs
  local inputYs = self.characterComponents.inputYs

  local runInputs = self.characterComponents.runInputs

  local oldJumpInputs = self.characterComponents.oldJumpInputs
  local jumpInputs = self.characterComponents.jumpInputs

  local ys = self.positionComponents.ys
  local previousYs = self.velocityComponents.previousYs

  for id in pairs(ids) do
    repeat
      if jumpInputs[id] and not oldJumpInputs[id] then
        ys[id] = previousYs[id] - runningJumpSpeed * dt
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

function M:transitionSliding(ids, dt, newStates)
  local slidingJumpSpeed = self.characterComponents.slidingJumpSpeed
  local directionXs = self.characterComponents.directionXs
  local animationTimes = self.characterComponents.animationTimes

  local inputXs = self.characterComponents.inputXs
  local inputYs = self.characterComponents.inputYs

  local oldJumpInputs = self.characterComponents.oldJumpInputs
  local jumpInputs = self.characterComponents.jumpInputs

  local ys = self.positionComponents.ys
  local previousYs = self.velocityComponents.previousYs

  for id in pairs(ids) do
    repeat
      if jumpInputs[id] and not oldJumpInputs[id] then
        ys[id] = previousYs[id] - slidingJumpSpeed * dt
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

function M:transitionSneaking(ids, dt, newStates)
  local sneakingJumpSpeed = self.characterComponents.sneakingJumpSpeed
  local directionXs = self.characterComponents.directionXs

  local inputXs = self.characterComponents.inputXs
  local inputYs = self.characterComponents.inputYs

  local oldJumpInputs = self.characterComponents.oldJumpInputs
  local jumpInputs = self.characterComponents.jumpInputs

  local ys = self.positionComponents.ys
  local previousYs = self.velocityComponents.previousYs

  for id in pairs(ids) do
    repeat
      if jumpInputs[id] and not oldJumpInputs[id] then
        ys[id] = previousYs[id] - sneakingJumpSpeed * dt
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

function M:transitionStanding(ids, dt, newStates)
  local standingJumpSpeed = self.characterComponents.standingJumpSpeed
  local animationTimes = self.characterComponents.animationTimes
  local directionXs = self.characterComponents.directionXs

  local inputXs = self.characterComponents.inputXs
  local inputYs = self.characterComponents.inputYs

  local oldJumpInputs = self.characterComponents.oldJumpInputs
  local jumpInputs = self.characterComponents.jumpInputs

  local ys = self.positionComponents.ys
  local previousYs = self.velocityComponents.previousYs

  for id in pairs(ids) do
    repeat
      if jumpInputs[id] and not oldJumpInputs[id] then
        ys[id] = previousYs[id] - standingJumpSpeed * dt
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

function M:transitionWalking(ids, dt, newStates)
  local walkingJumpSpeed = self.characterComponents.walkingJumpSpeed
  local directionXs = self.characterComponents.directionXs

  local inputXs = self.characterComponents.inputXs
  local inputYs = self.characterComponents.inputYs

  local runInputs = self.characterComponents.runInputs

  local oldJumpInputs = self.characterComponents.oldJumpInputs
  local jumpInputs = self.characterComponents.jumpInputs

  local ys = self.positionComponents.ys
  local previousYs = self.velocityComponents.previousYs

  for id in pairs(ids) do
    repeat
      if jumpInputs[id] and not oldJumpInputs[id] then
        ys[id] = previousYs[id] - walkingJumpSpeed * dt
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

function M:transitionWallSliding(ids, dt, newStates)
  local wallSlidingJumpSpeedX = self.characterComponents.wallSlidingJumpSpeedX
  local wallSlidingJumpSpeedY = self.characterComponents.wallSlidingJumpSpeedY

  local directionXs = self.characterComponents.directionXs
  local inputXs = self.characterComponents.inputXs

  local oldJumpInputs = self.characterComponents.oldJumpInputs
  local jumpInputs = self.characterComponents.jumpInputs

  local xs = self.positionComponents.xs
  local ys = self.positionComponents.ys

  local previousXs = self.velocityComponents.previousXs
  local previousYs = self.velocityComponents.previousYs

  for id in pairs(ids) do
    repeat
      if jumpInputs[id] and not oldJumpInputs[id] then
        newStates[id] = "falling"
        directionXs[id] = -directionXs[id]

        xs[id] = previousXs[id] + directionXs[id] * wallSlidingJumpSpeedX * dt
        ys[id] = previousYs[id] - wallSlidingJumpSpeedY * dt
        break
      end

      if inputXs[id] == -directionXs[id] then
        newStates[id] = "gliding"
        directionXs[id] = -directionXs[id]
        break
      end
    until true
  end
end

function M:transitionWallTouching(ids, dt, newStates)
  local standingJumpSpeed = self.characterComponents.standingJumpSpeed
  local animationTimes = self.characterComponents.animationTimes
  local directionXs = self.characterComponents.directionXs

  local inputXs = self.characterComponents.inputXs
  local inputYs = self.characterComponents.inputYs

  local oldJumpInputs = self.characterComponents.oldJumpInputs
  local jumpInputs = self.characterComponents.jumpInputs

  local ys = self.positionComponents.ys
  local previousYs = self.velocityComponents.previousYs

  for id in pairs(ids) do
    repeat
      if jumpInputs[id] and not oldJumpInputs[id] then
        newStates[id] = "wallSliding"
        ys[id] = previousYs[id] - standingJumpSpeed * dt
        break
      end

      if inputYs[id] == 1 then
        newStates[id] = "crouching"
        break
      end

      if inputXs[id] == -directionXs[id] then
        newStates[id] = "standing"
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

return M
