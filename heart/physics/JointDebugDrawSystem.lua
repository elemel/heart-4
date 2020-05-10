local class = require("heart.class")

local M = class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.physicsDomain = assert(self.game.domains.physics)
  self.color = config.color or {0, 1, 0, 1}
end

function M:__call(viewportId)
  local r, g, b, a = love.graphics.getColor()
  love.graphics.setColor(self.color)

  for i, joint in ipairs(self.physicsDomain.world:getJoints()) do
    local x1, y1, x2, y2 = joint:getAnchors()
    love.graphics.line(x1, y1, x2, y2)
  end

  love.graphics.setColor(r, g, b, a)
end

return M
