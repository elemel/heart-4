local class = require("heart.class")

local M = class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.physicsDomain = assert(self.game.domains.physics)
  self.riderEntities = assert(self.game.componentEntitySets.rider)
  self.cameraEntities = assert(self.game.componentEntitySets.camera)
  self.transformManager = assert(self.game.componentManagers.transform)
end

function M:__call(dt)
  local transforms = self.transformManager.transforms

  for riderId in pairs(self.riderEntities) do
    for cameraId in pairs(self.cameraEntities) do
      local x, y = transforms[riderId]:transformPoint(0, 0)
      transforms[cameraId]:reset():translate(x, y):scale(8)
    end
  end
end

return M
