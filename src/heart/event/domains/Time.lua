local class = require("heart.class")

local M = class.newClass()

function M:init(game, config)
  self.fixedDt = config.fixedDt or 1 / 60
  self.accumulatedDt = 0
end

return M
