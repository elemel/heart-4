local class = require("heart.class")
local mathUtils = require("heart.math.utils")

local AnimatedBodyFixedUpdateSystem = class.newClass()

function AnimatedBodyFixedUpdateSystem:init(game, config)
  self.game = assert(game)
  self.physicsDomain = assert(self.game.domains.physics)
  self.bones = assert(self.game.componentManagers.bone)

  self.animatedBodyTransformEntities =
    assert(self.game.componentEntitySets.animatedBodyTransform)
end

function AnimatedBodyFixedUpdateSystem:fixedUpdate(dt)
  local bodies = self.physicsDomain.bodies
  local transforms = self.bones.transforms

  for entityId in pairs(self.animatedBodyTransformEntities) do
    local x, y, angle = mathUtils.decompose2(transforms[entityId])
    local body = bodies[entityId]
    body:setPosition(x, y)
    body:setAngle(angle)
  end
end

return AnimatedBodyFixedUpdateSystem
