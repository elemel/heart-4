local heart = require("heart")

local M = heart.class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
end

function M:handleEvent(dt)
  local spiderEntities = self.engine.componentEntitySets.spider
  local spiderComponents = self.engine.componentManagers.spider
  local moveInputs = spiderComponents.moveInputs

  local upInput = love.keyboard.isDown("w")
  local leftInput = love.keyboard.isDown("a")
  local downInput = love.keyboard.isDown("s")
  local rightInput = love.keyboard.isDown("d")

  local inputX = (rightInput and 1 or 0) - (leftInput and 1 or 0)
  local inputY = (downInput and 1 or 0) - (upInput and 1 or 0)

  if inputX ~= 0 and inputY ~= 0 then
    inputX, inputY = heart.math.normalize2(inputX, inputY)
  end

  for id in pairs(spiderEntities) do
    moveInputs[id][1] = inputX
    moveInputs[id][2] = inputY
  end
end

return M
