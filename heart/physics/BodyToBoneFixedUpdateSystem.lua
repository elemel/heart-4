local class = require("heart.class")

local M = class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.physicsDomain = assert(self.game.domains.physics)
  self.transformComponents = assert(self.game.componentManagers.transform)
  self.boneEntities = assert(self.game.componentEntitySets.bone)
end

function M:__call(dt)
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
