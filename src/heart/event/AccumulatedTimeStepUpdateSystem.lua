local class = require("heart.class")

local AccumulatedTimeStepUpdateSystem = class.newClass()

function AccumulatedTimeStepUpdateSystem:init(game, config)
  self.game = assert(game)
  self.fixedTimeStepDomain = assert(self.game.domains.fixedTimeStep)
end

function AccumulatedTimeStepUpdateSystem:update(dt)
  local fixedTimeStep = self.fixedTimeStepDomain.fixedTimeStep

  self.fixedTimeStepDomain.accumulatedTimeStep =
    self.fixedTimeStepDomain.accumulatedTimeStep + dt

  while self.fixedTimeStepDomain.accumulatedTimeStep - fixedTimeStep >= 0 do
    self.fixedTimeStepDomain.accumulatedTimeStep =
      self.fixedTimeStepDomain.accumulatedTimeStep - fixedTimeStep

    self.game:handleEvent("fixedUpdate", fixedTimeStep)
  end
end

return AccumulatedTimeStepUpdateSystem
