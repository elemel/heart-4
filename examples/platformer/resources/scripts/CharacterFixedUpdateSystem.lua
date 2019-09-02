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
    standing = self.transitionStanding,
    walking = self.transitionWalking,
  }

  self.updateHandlers = {
    crouching = self.updateCrouching,
    gliding = self.updateGliding,
    running = self.updateRunning,
    sliding = self.updateSliding,
    standing = self.updateStanding,
    walking = self.updateWalking,
  }

  self.crouchingJumpSpeed = 6
  self.standingJumpSpeed = 10
  self.slidingJumpSpeed = 10
  self.walkingJumpSpeed = 13
  self.walkingSpeed = 3
  self.walkingAcceleration = 16
  self.standingAcceleration = 16
  self.runningJumpSpeed = 15
  self.runningSpeed = 5
  self.runningAcceleration = 16
  self.crouchingAcceleration = 8
  self.slidingAcceleration = 4
  self.glidingSpeed = 3
  self.glidingAcceleration = 8
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

      local leftInput = love.keyboard.isDown("a")
      local rightInput = love.keyboard.isDown("d")

      local inputX = (rightInput and 1 or 0) - (leftInput and 1 or 0)
      local directionX = directionXs[id]

      if inputX == -directionX then
        directionXs[id] = -directionX
        break
      end

      if inputX == directionX then
        -- newStates[id] = "sneaking"
        -- animationTimes[id] = 0
        -- break
      end

      local jumpInput = love.keyboard.isDown("k")

      if jumpInput then
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

  for id in pairs(ids) do
    repeat
      local constraintMap = constraintMaps[id]

      if constraintMap.down then
        newStates[id] = "standing"
        break
      end

      local leftInput = love.keyboard.isDown("a")
      local rightInput = love.keyboard.isDown("d")

      local inputX = (rightInput and 1 or 0) - (leftInput and 1 or 0)
      local directionX = directionXs[id]

      if inputX ~= directionX then
        newStates[id] = "falling"
        break
      end

    until true
  end
end

function CharacterFixedUpdateSystem:transitionFalling(ids, dt, newStates)
  local constraintMaps = self.colliderComponents.constraintMaps
  local directionXs = self.characterComponents.directionXs

  for id in pairs(ids) do
    repeat
      local constraintMap = constraintMaps[id]

      if constraintMap.down then
        newStates[id] = "standing"
        break
      end

      local leftInput = love.keyboard.isDown("a")
      local rightInput = love.keyboard.isDown("d")

      local inputX = (rightInput and 1 or 0) - (leftInput and 1 or 0)
      local directionX = directionXs[id]

      if inputX == -directionX then
        directionXs[id] = -directionX
        break
      end

      if inputX == directionX then
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
        newStates[id] = "sliding"
        break
      end

      local runInput = love.keyboard.isDown("j")

      if not runInput then
        newStates[id] = "walking"
        break
      end

      local leftInput = love.keyboard.isDown("a")
      local rightInput = love.keyboard.isDown("d")

      local inputX = (rightInput and 1 or 0) - (leftInput and 1 or 0)
      local directionX = directionXs[id]

      if inputX ~= directionX then
        newStates[id] = "walking"
        break
      end

      local jumpInput = love.keyboard.isDown("k")

      if jumpInput then
        ys[id] = ys[id] - self.runningJumpSpeed * dt
        newStates[id] = "falling"
        break
      end
    until true
  end
end

function CharacterFixedUpdateSystem:transitionSliding(ids, dt, newStates)
  local constraintMaps = self.colliderComponents.constraintMaps
  local ys = self.positionComponents.ys
  local directionXs = self.characterComponents.directionXs

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
        newStates[id] = "running"
        break
      end

      local leftInput = love.keyboard.isDown("a")
      local rightInput = love.keyboard.isDown("d")

      local inputX = (rightInput and 1 or 0) - (leftInput and 1 or 0)
      local directionX = directionXs[id]

      if inputX ~= directionX then
        newStates[id] = "crouching"
        break
      end

      local jumpInput = love.keyboard.isDown("k")

      if jumpInput then
        ys[id] = ys[id] - self.slidingJumpSpeed * dt
        newStates[id] = "falling"
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

      local leftInput = love.keyboard.isDown("a")
      local rightInput = love.keyboard.isDown("d")

      local inputX = (rightInput and 1 or 0) - (leftInput and 1 or 0)
      local directionX = directionXs[id]

      if inputX == -directionX then
        directionXs[id] = -directionX
        break
      end

      if inputX == directionX then
        newStates[id] = "walking"
        animationTimes[id] = 0
        break
      end

      local jumpInput = love.keyboard.isDown("k")

      if jumpInput then
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

      if inputY == -1 then
        newStates[id] = "running"
        break
      end

      if inputY == 1 then
        newStates[id] = "crouching"
        break
      end

      local leftInput = love.keyboard.isDown("a")
      local rightInput = love.keyboard.isDown("d")

      local inputX = (rightInput and 1 or 0) - (leftInput and 1 or 0)
      local directionX = directionXs[id]

      if inputX ~= directionX then
        newStates[id] = "standing"
        break
      end

      local runInput = love.keyboard.isDown("j")

      if runInput then
        newStates[id] = "running"
        break
      end

      local jumpInput = love.keyboard.isDown("k")

      if jumpInput then
        ys[id] = ys[id] - self.walkingJumpSpeed * dt
        newStates[id] = "falling"
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

  local leftInput = love.keyboard.isDown("a")
  local rightInput = love.keyboard.isDown("d")

  local inputX = (rightInput and 1 or 0) - (leftInput and 1 or 0)
  local targetVelocityX = inputX * self.glidingSpeed
  local targetDx = targetVelocityX * dt
  local maxDdx = self.glidingAcceleration * dt * dt

  for id in pairs(ids) do
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

  local leftInput = love.keyboard.isDown("a")
  local rightInput = love.keyboard.isDown("d")

  local inputX = (rightInput and 1 or 0) - (leftInput and 1 or 0)
  local maxDdx = self.runningAcceleration * dt * dt

  for id in pairs(ids) do
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

  local leftInput = love.keyboard.isDown("a")
  local rightInput = love.keyboard.isDown("d")

  local inputX = (rightInput and 1 or 0) - (leftInput and 1 or 0)
  local targetVelocityX = inputX * self.walkingSpeed
  local targetDx = targetVelocityX * dt
  local maxDdx = self.walkingAcceleration * dt * dt

  for id in pairs(ids) do
    local dx = xs[id] - previousXs[id]
    local ddx = clamp(targetDx - dx, -maxDdx, maxDdx)
    xs[id] = xs[id] + ddx
  end
end

return CharacterFixedUpdateSystem
