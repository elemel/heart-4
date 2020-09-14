local heart = require("heart")

local M = heart.class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.levelDomain = assert(self.engine.domains.level)
  self.color = config.color or {0, 1, 0, 1}
end

function M:handleEvent(viewportId)
  local r, g, b, a = love.graphics.getColor()
  love.graphics.setColor(self.color)

  local minPoint, maxPoint = unpack(self.levelDomain.bounds)

  local minX, minY = unpack(minPoint)
  local maxX, maxY = unpack(maxPoint)

  love.graphics.line(minX, minY, maxX, minY, maxX, maxY, minX, maxY, minX, minY)
  local r, g, b, a = love.graphics.getColor()
end

return M
