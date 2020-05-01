local class = require("heart.class")

local M = class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.physicsDomain = assert(self.game.domains.physics)
end

function M:fixedUpdate(dt)
  self.physicsDomain.world:update(dt)
end

return M
