local class = require("heart.class")

local TimeUpdateSystem = class.newClass()

function TimeUpdateSystem:init(game, config)
  self.game = assert(game)
  self.timeDomain = assert(self.game.domains.time)
end

function TimeUpdateSystem:update(dt)
  local fixedDt = self.timeDomain.fixedDt
  self.timeDomain.accumulatedDt = self.timeDomain.accumulatedDt + dt

  while self.timeDomain.accumulatedDt - fixedDt >= 0 do
    self.timeDomain.accumulatedDt = self.timeDomain.accumulatedDt - fixedDt
    self.game:handleEvent("fixedUpdate", fixedDt)
  end
end

return TimeUpdateSystem
