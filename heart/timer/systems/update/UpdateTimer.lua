local class = require("heart.class")

local M = class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.timerDomain = assert(self.game.domains.timer)
end

function M:update(dt)
  local fixedDt = self.timerDomain.fixedDt
  self.timerDomain.accumulatedDt = self.timerDomain.accumulatedDt + dt

  while self.timerDomain.accumulatedDt - fixedDt >= 0 do
    self.timerDomain.accumulatedDt = self.timerDomain.accumulatedDt - fixedDt
    self.game:handleEvent("fixedUpdate", fixedDt)
  end
end

return M
