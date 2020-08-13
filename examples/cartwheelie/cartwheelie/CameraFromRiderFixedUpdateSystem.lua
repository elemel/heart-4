local class = require("heart.class")

local M = class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.physicsDomain = assert(self.engine.domains.physics)
  self.riderEntities = assert(self.engine.componentEntitySets.rider)
  self.cameraEntities = assert(self.engine.componentEntitySets.camera)
  self.transformComponents = assert(self.engine.componentManagers.transform)
end

function M:handleEvent(dt)
  local transforms = self.transformComponents.transforms

  for riderId in pairs(self.riderEntities) do
    for cameraId in pairs(self.cameraEntities) do
      local x, y = transforms[riderId]:transformPoint(0, 0)
      transforms[cameraId]:reset():translate(x, y):scale(8)
    end
  end
end

return M
