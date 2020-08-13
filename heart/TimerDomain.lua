local class = require("heart.class")

local M = class.newClass()

function M:init(engine, config)
  self.fixedDt = config.fixedDt or 1 / 60
  self.accumulatedDt = 0
  self.fixedCount = 0
end

function M:getFraction()
  return self.accumulatedDt / self.fixedDt
end

function M:getTime()
  return self.fixedCount * self.fixedDt + self.accumulatedDt
end

function M:getFixedTime()
  return self.fixedCount * self.fixedDt
end

return M
