local class = require("heart.class")

local WorldFixedUpdateSystem = class.newClass()

function WorldFixedUpdateSystem:init(game, config)
  self.game = assert(game)
  self.physicsDomain = assert(self.game.domains.physics)
end

function WorldFixedUpdateSystem:fixedUpdate(dt)
  self.physicsDomain.world:update(dt)
end

return WorldFixedUpdateSystem
