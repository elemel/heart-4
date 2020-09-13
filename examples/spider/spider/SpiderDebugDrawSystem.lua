local heart = require("heart")

local M = heart.class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
end

function M:handleEvent(viewportId)
  local r, g, b, a = love.graphics.getColor()
  love.graphics.setColor(1, 1, 0, 1)

  local physicsDomain = self.engine.domains.physics
  local bodies = physicsDomain.bodies
  local circleFixtures = physicsDomain.circleFixtures
  local spiderEntities = self.engine.componentEntitySets.spider
  local transformComponents = self.engine.componentManagers.transform

  for id in pairs(spiderEntities) do
    for _, contact in ipairs(bodies[id]:getContacts()) do
      if contact:isTouching() then
        local fixture1, fixture2 = contact:getFixtures()

        local x1, y1 = fixture1:getBody():getPosition()
        local x2, y2 = fixture2:getBody():getPosition()

        -- love.graphics.line(x1, y1, x2, y2)

        local fixture3 = circleFixtures[id]
        local fixture4 = (fixture1:getBody() == bodies[id]) and fixture2 or fixture1

        local distance, x3, y3, x4, y4 = love.physics.getDistance(fixture3, fixture4)
        love.graphics.line(x3, y3, x4, y4)
      end
    end
  end

  love.graphics.setColor(r, g, b, a)
end

return M
