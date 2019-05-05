local class = require("heart.class")
local mathUtils = require("heart.math.utils")

local MinecartPlayerFixedUpdateSystem = class.newClass()

function MinecartPlayerFixedUpdateSystem:init(game, config)
  self.game = assert(game)
  self.physicsDomain = assert(self.game.domains.physics)

  self.minecartPlayerEntities =
    assert(self.game.componentEntitySets.minecartPlayer)
end

function MinecartPlayerFixedUpdateSystem:fixedUpdate(dt)
  local leftInput = love.keyboard.isDown("a")
  local rightInput = love.keyboard.isDown("d")
  local inputX = (rightInput and 1 or 0) - (leftInput and 1 or 0)

  for entityId in pairs(self.minecartPlayerEntities) do
    for _, wheelJointId in ipairs(self.game:findDescendantComponents(entityId, "wheelJoint")) do
      local wheelJoint = assert(self.physicsDomain.wheelJoints[wheelJointId])
      wheelJoint:setMaxMotorTorque(5 * math.abs(inputX))
      wheelJoint:setMotorSpeed(10 * inputX)
    end
  end
end

return MinecartPlayerFixedUpdateSystem
