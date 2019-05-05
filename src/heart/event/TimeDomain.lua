local class = require("heart.class")

local TimeDomain = class.newClass()

function TimeDomain:init(game, config)
  self.fixedTimeStep = config.fixedTimeStep or 1 / 60
  self.accumulatedTimeStep = 0
end

return TimeDomain
