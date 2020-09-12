local class = require("heart.class")

local M = class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.physicsDomain = assert(self.engine.domains.physics)
  self.transformComponents = assert(self.engine.componentManagers.transform)
end

function M:handleEvent(dt)
  for id, body in pairs(self.physicsDomain.bodies) do
    if body:getType() == "dynamic" then
      local x, y = body:getPosition()
      local angle = body:getAngle()

      self.transformComponents:setMode(id, "world")
      self.transformComponents.transforms[id]:setTransform2(x, y, angle)
      self.transformComponents:setDirty(id, true)
    end
  end
end

return M
