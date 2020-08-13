local class = require("heart.class")

local M = class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.physicsDomain = assert(self.engine.domains.physics)
  self.transformComponents = assert(self.engine.componentManagers.transform)
  self.boneEntities = assert(self.engine.componentEntitySets.bone)
end

function M:handleEvent(dt)
  local bodies = self.physicsDomain.bodies
  local transforms = self.transformComponents.transforms

  for entityId in pairs(self.boneEntities) do
    local body = bodies[entityId]

    if body then
      local x, y = body:getPosition()
      local angle = body:getAngle()
      transforms[entityId]:setTransformation(x, y, angle)
    end
  end
end

return M
