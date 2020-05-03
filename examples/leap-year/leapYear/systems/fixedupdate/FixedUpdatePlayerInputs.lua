local M = heart.class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.playerEntities = assert(self.game.componentEntitySets.player)
  self.characterManager = assert(self.game.componentManagers.character)
end

function M:fixedupdate(dt)
  local oldInputXs = self.characterManager.oldInputXs
  local oldInputYs = self.characterManager.oldInputYs

  local oldRunInputs = self.characterManager.oldRunInputs
  local oldJumpInputs = self.characterManager.oldJumpInputs

  local inputXs = self.characterManager.inputXs
  local inputYs = self.characterManager.inputYs

  local runInputs = self.characterManager.runInputs
  local jumpInputs = self.characterManager.jumpInputs

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
