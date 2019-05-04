local class = require("heart.class")

local FixedTimeStepDomain = class.newClass()

function FixedTimeStepDomain:init(game, config)
  self.fixedTimeStep = config.fixedTimeStep or 1 / 60
  self.accumulatedTimeStep = 0
end

return FixedTimeStepDomain
