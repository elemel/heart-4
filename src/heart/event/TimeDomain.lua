local class = require("heart.class")

local TimeDomain = class.newClass()

function TimeDomain:init(game, config)
  self.fixedDt = config.fixedDt or 1 / 60
  self.accumulatedDt = 0
end

return TimeDomain
