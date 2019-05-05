local class = require("heart.class")

local TimeUpdateSystem = class.newClass()

function TimeUpdateSystem:init(game, config)
  self.game = assert(game)
  self.timeDomain = assert(self.game.domains.time)
end

function TimeUpdateSystem:update(dt)
  local fixedTimeStep = self.timeDomain.fixedTimeStep

  self.timeDomain.accumulatedTimeStep =
    self.timeDomain.accumulatedTimeStep + dt

  while self.timeDomain.accumulatedTimeStep - fixedTimeStep >= 0 do
    self.timeDomain.accumulatedTimeStep =
      self.timeDomain.accumulatedTimeStep - fixedTimeStep

    self.game:handleEvent("fixedUpdate", fixedTimeStep)
  end
end

return TimeUpdateSystem
