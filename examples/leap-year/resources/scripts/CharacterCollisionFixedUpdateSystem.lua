local clamp = heart.math.clamp

local CharacterCollisionFixedUpdateSystem = heart.class.newClass()

function CharacterCollisionFixedUpdateSystem:init(game, config)
  self.game = assert(game)

  self.characterEntities = assert(self.game.componentEntitySets.character)
  self.characterComponents = assert(self.game.componentManagers.character)

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
    wallSliding = self.transitionWallSliding,
    wallTouching = self.transitionWallTouching,
  }
end

function CharacterCollisionFixedUpdateSystem:fixedUpdate(dt)
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

function CharacterCollisionFixedUpdateSystem:transitionCrouching(ids, dt, newStates)
  local constraintMaps = self.colliderComponents.constraintMaps

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

function CharacterCollisionFixedUpdateSystem:transitionGliding(ids, dt, newStates)
  local constraintMaps = self.colliderComponents.constraintMaps
  local directionXs = self.characterComponents.directionXs
  local animationTimes = self.characterComponents.animationTimes

  local runInputs = self.characterComponents.runInputs

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

function CharacterCollisionFixedUpdateSystem:transitionFalling(ids, dt, newStates)
  local constraintMaps = self.colliderComponents.constraintMaps
  local directionXs = self.characterComponents.directionXs

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

function CharacterCollisionFixedUpdateSystem:transitionRunning(ids, dt, newStates)
  local constraintMaps = self.colliderComponents.constraintMaps

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

function CharacterCollisionFixedUpdateSystem:transitionSliding(ids, dt, newStates)
  local constraintMaps = self.colliderComponents.constraintMaps

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

function CharacterCollisionFixedUpdateSystem:transitionSneaking(ids, dt, newStates)
  local constraintMaps = self.colliderComponents.constraintMaps

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

function CharacterCollisionFixedUpdateSystem:transitionStanding(ids, dt, newStates)
  local constraintMaps = self.colliderComponents.constraintMaps
  local directionXs = self.characterComponents.directionXs

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

function CharacterCollisionFixedUpdateSystem:transitionWalking(ids, dt, newStates)
  local constraintMaps = self.colliderComponents.constraintMaps

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

function CharacterCollisionFixedUpdateSystem:transitionWallSliding(ids, dt, newStates)
  local constraintMaps = self.colliderComponents.constraintMaps
  local directionXs = self.characterComponents.directionXs

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

function CharacterCollisionFixedUpdateSystem:transitionWallTouching(ids, dt, newStates)
  local constraintMaps = self.colliderComponents.constraintMaps
  local directionXs = self.characterComponents.directionXs

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

return CharacterCollisionFixedUpdateSystem
