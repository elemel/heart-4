local class = require("heart.class")

local DynamicBodyFixedUpdateSystem = class.newClass()

function DynamicBodyFixedUpdateSystem:init(game, config)
  self.game = assert(game)
  self.physicsDomain = assert(self.game.domains.physics)
  self.bones = assert(self.game.componentManagers.bone)

  self.dynamicBodyTransformEntities =
    assert(self.game.componentEntitySets.dynamicBodyTransform)
end

function DynamicBodyFixedUpdateSystem:fixedUpdate(dt)
  local bodies = self.physicsDomain.bodies
  local transforms = self.bones.transforms

  for entityId in pairs(self.dynamicBodyTransformEntities) do
    local body = bodies[entityId]
    local x, y = body:getPosition()
    local angle = body:getAngle()
    transforms[entityId]:setTransformation(x, y, angle)
  end
end

return DynamicBodyFixedUpdateSystem
