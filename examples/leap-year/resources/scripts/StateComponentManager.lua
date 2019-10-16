local set2 = heart.table.set2

local StateComponentManager = heart.class.newClass()

function StateComponentManager:init(game, config)
  self.defaultState = config.defaultState
  self.states = {}
  self.stateEntitySets = {}
end

function StateComponentManager:createComponent(id, config)
  local state = config.state or self.defaultState
  self.states[id] = state
  set2(self.stateEntitySets, state, id, true)
end

function StateComponentManager:destroyComponent(id)
  local state = self.states[id]
  set2(self.stateEntitySets, state, id, nil)
  self.states[id] = nil
end

function StateComponentManager:setState(id, state)
  local oldState = self.states[id]

  if state ~= oldState then
    set2(self.stateEntitySets, oldState, id, nil)
    set2(self.stateEntitySets, state, id, true)
    self.states[id] = state
  end
end

return StateComponentManager
