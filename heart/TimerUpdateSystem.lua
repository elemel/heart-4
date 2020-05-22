local class = require("heart.class")

local M = class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.timerDomain = assert(self.game.domains.timer)
end

function M:__call(dt)
  self.timerDomain.accumulatedDt = self.timerDomain.accumulatedDt + dt

  while self.timerDomain.accumulatedDt >= self.timerDomain.fixedDt do
    self.timerDomain.accumulatedDt =
      self.timerDomain.accumulatedDt - self.timerDomain.fixedDt

    self.timerDomain.fixedCount = self.timerDomain.fixedCount + 1
    self.game:handleEvent("fixedupdate", self.timerDomain.fixedDt)
  end
end

return M
