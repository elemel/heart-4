local clamp = heart.math.clamp

local M = heart.class.newClass()

function M:init(game, config)
  self.game = assert(game)

  self.characterEntities = assert(self.game.componentEntitySets.character)
  self.characterManager = assert(self.game.componentManagers.character)

  self.characterStateManager = assert(self.game.componentManagers.characterState)
  self.colliderManager = assert(self.game.componentManagers.collider)

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

function M:fixedupdate(dt)
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
  local constraintMaps = self.colliderManager.constraintMaps

  for id in pairs(ids) do
    repeat
      local constraintMap = constraintMaps[id]

      if not constraintMap.down then
        newStates[id] = "falling"
        break
      end
    until true
  end
end

function M:transitionGliding(ids, dt, newStates)
  local constraintMaps = self.colliderManager.constraintMaps
  local directionXs = self.characterManager.directionXs
  local animationTimes = self.characterManager.animationTimes

  local runInputs = self.characterManager.runInputs

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
        break
      end

      if not constraintMap.left and constraintMap.right and directionXs[id] == 1 then
        newStates[id] = "wallSliding"
        break
      end
    until true
  end
end

function M:transitionFalling(ids, dt, newStates)
  local constraintMaps = self.colliderManager.constraintMaps
  local directionXs = self.characterManager.directionXs

  for id in pairs(ids) do
    repeat
      local constraintMap = constraintMaps[id]

      if constraintMap.down then
        newStates[id] = "standing"
        break
      end

      if constraintMap.left and not constraintMap.right and directionXs[id] == -1 then
        newStates[id] = "wallSliding"
        break
      end

      if not constraintMap.left and constraintMap.right and directionXs[id] == 1 then
        newStates[id] = "wallSliding"
        break
      end
    until true
  end
end

function M:transitionRunning(ids, dt, newStates)
  local constraintMaps = self.colliderManager.constraintMaps

  for id in pairs(ids) do
    repeat
      local constraintMap = constraintMaps[id]

      if not constraintMap.down then
        newStates[id] = "gliding"
        break
      end
    until true
  end
end

function M:transitionSliding(ids, dt, newStates)
  local constraintMaps = self.colliderManager.constraintMaps

  for id in pairs(ids) do
    repeat
      local constraintMap = constraintMaps[id]

      if not constraintMap.down then
        newStates[id] = "gliding"
        break
      end
    until true
  end
end

function M:transitionSneaking(ids, dt, newStates)
  local constraintMaps = self.colliderManager.constraintMaps

  for id in pairs(ids) do
    repeat
      local constraintMap = constraintMaps[id]

      if not constraintMap.down then
        newStates[id] = "gliding"
        break
      end
    until true
  end
end

function M:transitionStanding(ids, dt, newStates)
  local constraintMaps = self.colliderManager.constraintMaps
  local directionXs = self.characterManager.directionXs

  for id in pairs(ids) do
    repeat
      local constraintMap = constraintMaps[id]

      if not constraintMap.down then
        newStates[id] = "falling"
        break
      end

      if directionXs[id] == -1 and constraintMap.left then
        newStates[id] = "wallTouching"
        break
      end

      if directionXs[id] == 1 and constraintMap.right then
        newStates[id] = "wallTouching"
        break
      end
    until true
  end
end

function M:transitionWalking(ids, dt, newStates)
  local constraintMaps = self.colliderManager.constraintMaps

  for id in pairs(ids) do
    repeat
      local constraintMap = constraintMaps[id]

      if not constraintMap.down then
        newStates[id] = "gliding"
        break
      end
    until true
  end
end

function M:transitionWallSliding(ids, dt, newStates)
  local constraintMaps = self.colliderManager.constraintMaps
  local directionXs = self.characterManager.directionXs

  for id in pairs(ids) do
    repeat
      local constraintMap = constraintMaps[id]

      if directionXs[id] == -1 and not constraintMap.left then
        newStates[id] = "falling"
        break
      end

      if directionXs[id] == 1 and not constraintMap.right then
        newStates[id] = "falling"
        break
      end

      if constraintMap.down then
        newStates[id] = "wallTouching"
        break
      end
    until true
  end
end

function M:transitionWallTouching(ids, dt, newStates)
  local constraintMaps = self.colliderManager.constraintMaps
  local directionXs = self.characterManager.directionXs

  for id in pairs(ids) do
    repeat
      local constraintMap = constraintMaps[id]

      if not constraintMap.down then
        newStates[id] = "wallSliding"
        break
      end

      if directionXs[id] == -1 and not constraintMap.left then
        newStates[id] = "standing"
        break
      end

      if directionXs[id] == 1 and not constraintMap.right then
        newStates[id] = "standing"
        break
      end
    until true
  end
end

return M
