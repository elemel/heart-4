local clamp = heart.math.clamp

local M = heart.class.newClass()

function M:init(game, config)
  self.game = assert(game)

  self.characterEntities = assert(self.game.componentEntitySets.character)
  self.characterManager = assert(self.game.componentManagers.character)

  self.positionManager = assert(self.game.componentManagers.position)
  self.velocityManager = assert(self.game.componentManagers.velocity)
  self.characterStateManager = assert(self.game.componentManagers.characterState)

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

function M:fixedUpdate(dt)
  local newStates = {}

  for state, ids in pairs(self.characterStateManager.stateEntitySets) do
    local handler = self.transitionHandlers[state]

    if handler then
      handler(self, ids, dt, newStates)
    end
  end

  for id, state in pairs(newStates) do
    self.characterStateManager:setState(id, state)
  end
end

function M:transitionCrouching(ids, dt, newStates)
  local crouchingJumpSpeed = self.characterManager.crouchingJumpSpeed
  local directionXs = self.characterManager.directionXs
  local animationTimes = self.characterManager.animationTimes

  local inputXs = self.characterManager.inputXs
  local inputYs = self.characterManager.inputYs

  local oldJumpInputs = self.characterManager.oldJumpInputs
  local jumpInputs = self.characterManager.jumpInputs

  local ys = self.positionManager.ys
  local previousYs = self.velocityManager.previousYs

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
  local directionXs = self.characterManager.directionXs
  local inputXs = self.characterManager.inputXs

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
  local directionXs = self.characterManager.directionXs
  local inputXs = self.characterManager.inputXs

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
  local runningJumpSpeed = self.characterManager.runningJumpSpeed
  local directionXs = self.characterManager.directionXs

  local inputXs = self.characterManager.inputXs
  local inputYs = self.characterManager.inputYs

  local runInputs = self.characterManager.runInputs

  local oldJumpInputs = self.characterManager.oldJumpInputs
  local jumpInputs = self.characterManager.jumpInputs

  local ys = self.positionManager.ys
  local previousYs = self.velocityManager.previousYs

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
  local slidingJumpSpeed = self.characterManager.slidingJumpSpeed
  local directionXs = self.characterManager.directionXs
  local animationTimes = self.characterManager.animationTimes

  local inputXs = self.characterManager.inputXs
  local inputYs = self.characterManager.inputYs

  local oldJumpInputs = self.characterManager.oldJumpInputs
  local jumpInputs = self.characterManager.jumpInputs

  local ys = self.positionManager.ys
  local previousYs = self.velocityManager.previousYs

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
  local sneakingJumpSpeed = self.characterManager.sneakingJumpSpeed
  local directionXs = self.characterManager.directionXs

  local inputXs = self.characterManager.inputXs
  local inputYs = self.characterManager.inputYs

  local oldJumpInputs = self.characterManager.oldJumpInputs
  local jumpInputs = self.characterManager.jumpInputs

  local ys = self.positionManager.ys
  local previousYs = self.velocityManager.previousYs

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
  local standingJumpSpeed = self.characterManager.standingJumpSpeed
  local animationTimes = self.characterManager.animationTimes
  local directionXs = self.characterManager.directionXs

  local inputXs = self.characterManager.inputXs
  local inputYs = self.characterManager.inputYs

  local oldJumpInputs = self.characterManager.oldJumpInputs
  local jumpInputs = self.characterManager.jumpInputs

  local ys = self.positionManager.ys
  local previousYs = self.velocityManager.previousYs

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
  local walkingJumpSpeed = self.characterManager.walkingJumpSpeed
  local directionXs = self.characterManager.directionXs

  local inputXs = self.characterManager.inputXs
  local inputYs = self.characterManager.inputYs

  local runInputs = self.characterManager.runInputs

  local oldJumpInputs = self.characterManager.oldJumpInputs
  local jumpInputs = self.characterManager.jumpInputs

  local ys = self.positionManager.ys
  local previousYs = self.velocityManager.previousYs

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
  local wallSlidingJumpSpeedX = self.characterManager.wallSlidingJumpSpeedX
  local wallSlidingJumpSpeedY = self.characterManager.wallSlidingJumpSpeedY

  local directionXs = self.characterManager.directionXs
  local inputXs = self.characterManager.inputXs

  local oldJumpInputs = self.characterManager.oldJumpInputs
  local jumpInputs = self.characterManager.jumpInputs

  local xs = self.positionManager.xs
  local ys = self.positionManager.ys

  local previousXs = self.velocityManager.previousXs
  local previousYs = self.velocityManager.previousYs

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
  local standingJumpSpeed = self.characterManager.standingJumpSpeed
  local animationTimes = self.characterManager.animationTimes
  local directionXs = self.characterManager.directionXs

  local inputXs = self.characterManager.inputXs
  local inputYs = self.characterManager.inputYs

  local oldJumpInputs = self.characterManager.oldJumpInputs
  local jumpInputs = self.characterManager.jumpInputs

  local ys = self.positionManager.ys
  local previousYs = self.velocityManager.previousYs

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
