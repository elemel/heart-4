local class = require("heart.class")

local M = class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.timerDomain = assert(self.engine.domains.timer)
end

function M:handleEvent(dt)
  self.timerDomain.accumulatedDt = self.timerDomain.accumulatedDt + dt

  while self.timerDomain.accumulatedDt >= self.timerDomain.fixedDt do
    self.timerDomain.accumulatedDt =
      self.timerDomain.accumulatedDt - self.timerDomain.fixedDt

    self.timerDomain.fixedCount = self.timerDomain.fixedCount + 1
    self.engine:handleEvent("fixedupdate", self.timerDomain.fixedDt)
  end
end

return M
