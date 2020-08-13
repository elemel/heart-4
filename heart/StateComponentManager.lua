local class = require("heart.class")
local heartTable = require("heart.table")

local M = class.newClass()

function M:init(engine, config)
  self.defaultState = config.defaultState

  if config.validStates then
    self.defaultState = self.defaultState or config.validStates[1]

    self.validStates = {}

    for _, state in ipairs(config.validStates) do
      self.validStates[state] = true
    end
  end

  self.states = {}
  self.stateEntitySets = {}
end

function M:createComponent(id, config)
  local state = config.state or self.defaultState

  if self.validStates then
    assert(self.validStates[state], "Invalid state")
  end

  self.states[id] = state

  if state then
    heartTable.set2(self.stateEntitySets, state, id, true)
  end
end

function M:destroyComponent(id)
  local state = self.states[id]

  if state then
    heartTable.set2(self.stateEntitySets, state, id, nil)
  end

  self.states[id] = nil
end

function M:setState(id, state)
  local oldState = self.states[id]

  if state ~= oldState then
    if self.validStates then
      assert(self.validStates[state], "Invalid state")
    end

    if oldState then
      heartTable.set2(self.stateEntitySets, oldState, id, nil)
    end

    self.states[id] = state

    if state then
      heartTable.set2(self.stateEntitySets, state, id, true)
    end
  end
end

return M
