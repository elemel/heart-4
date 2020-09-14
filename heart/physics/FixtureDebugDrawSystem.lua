local class = require("heart.class")

local M = class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.physicsDomain = assert(self.engine.domains.physics)

  -- TODO: Custom debug color per fixture
  self.color = config.color or {0, 1, 0, 1}
  self.sensorColor = config.sensorColor or {0, 1, 0, 0.25}
end

function M:handleEvent(viewportId)
  local r, g, b, a = love.graphics.getColor()

  for i, body in ipairs(self.physicsDomain.world:getBodies()) do
    local bodyComponent = body:getUserData()

    for j, fixture in ipairs(body:getFixtures()) do
      local shape = fixture:getShape()
      local shapeType = shape:getType()

      if fixture:isSensor() then
        love.graphics.setColor(self.sensorColor)
      else
        love.graphics.setColor(self.color)
      end

      if shapeType == "polygon" then
        love.graphics.polygon("line", body:getWorldPoints(shape:getPoints()))
      elseif shapeType == "circle" then
        local x, y = body:getWorldPoint(shape:getPoint())
        local radius = shape:getRadius()
        love.graphics.circle("line", x, y, radius, 16)
        local angle = body:getAngle()

        love.graphics.line(
            x,
            y,
            x + radius * math.cos(angle),
            y + radius * math.sin(angle))
      elseif shapeType == "chain" then
        love.graphics.line(body:getWorldPoints(shape:getPoints()))
      end
    end
  end

  love.graphics.setColor(r, g, b, a)
end

return M
