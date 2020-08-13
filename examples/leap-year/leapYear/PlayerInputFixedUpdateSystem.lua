local M = heart.class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.playerEntities = assert(self.engine.componentEntitySets.player)
  self.characterComponents = assert(self.engine.componentManagers.character)
end

function M:handleEvent(dt)
  local oldInputXs = self.characterComponents.oldInputXs
  local oldInputYs = self.characterComponents.oldInputYs

  local oldRunInputs = self.characterComponents.oldRunInputs
  local oldJumpInputs = self.characterComponents.oldJumpInputs

  local inputXs = self.characterComponents.inputXs
  local inputYs = self.characterComponents.inputYs

  local runInputs = self.characterComponents.runInputs
  local jumpInputs = self.characterComponents.jumpInputs

  for id in pairs(self.playerEntities) do
    oldInputXs[id] = inputXs[id]
    oldInputYs[id] = inputYs[id]

    oldRunInputs[id] = runInputs[id]
    oldJumpInputs[id] = jumpInputs[id]

    local leftInput = love.keyboard.isDown("a")
    local rightInput = love.keyboard.isDown("d")

    local upInput = love.keyboard.isDown("w")
    local downInput = love.keyboard.isDown("s")

    inputXs[id] = (rightInput and 1 or 0) - (leftInput and 1 or 0)
    inputYs[id] = (downInput and 1 or 0) - (upInput and 1 or 0)

    runInputs[id] = love.keyboard.isDown("j")
    jumpInputs[id] = love.keyboard.isDown("k")
  end
end

return M
