local class = require("heart.class")
local mathUtils = require("heart.math.utils")

local KinematicBodyFixedUpdateSystem = class.newClass()

function KinematicBodyFixedUpdateSystem:init(game, config)
  self.game = assert(game)
  self.physicsDomain = assert(self.game.domains.physics)
  self.bones = assert(self.game.componentManagers.bone)

  self.kinematicBodyTransformEntities =
    assert(self.game.componentEntitySets.kinematicBodyTransform)
end

function KinematicBodyFixedUpdateSystem:fixedUpdate(dt)
  local transforms = self.bones.transforms
  local bodies = self.physicsDomain.bodies

  for entityId in pairs(self.kinematicBodyTransformEntities) do
    local body = bodies[entityId]
    local x1, y1 = body:getPosition()
    local angle1 = body:getAngle()
    local transform = transformManager:getWorldTransform(entityId)
    local x2, y2, angle2 = mathUtils.decompose2(transform)

    local linearVelocityX = (x2 - x1) / dt
    local linearVelocityY = (y2 - y1) / dt
    body:setLinearVelocity(linearVelocityX, linearVelocityY)

    angularVelocity = (angle2 - angle1) / dt
    body:setAngularVelocity(angularVelocity)
  end
end

return KinematicBodyFixedUpdateSystem
