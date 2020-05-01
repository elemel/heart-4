local class = require("heart.class")

local M = class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.physicsDomain = assert(self.game.domains.physics)
  self.riderEntities = assert(self.game.componentEntitySets.rider)
  self.cameraEntities = assert(self.game.componentEntitySets.camera)
  self.transformComponents = assert(self.game.componentManagers.transform)
end

function M:fixedUpdate(dt)
  local transforms = self.transformComponents.transforms

  for riderId in pairs(self.riderEntities) do
    for cameraId in pairs(self.cameraEntities) do
      local x, y = transforms[riderId]:transformPoint(0, 0)
      transforms[cameraId]:reset():translate(x, y):scale(8)
    end
  end
end

return M
