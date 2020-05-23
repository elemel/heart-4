local class = require("heart.class")

local M = class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.physicsDomain = assert(self.game.domains.physics)
  self.minecartEntities = assert(self.game.componentEntitySets.minecart)
end

function M:handleEvent(dt)
  local leftInput = love.keyboard.isDown("a")
  local rightInput = love.keyboard.isDown("d")
  local inputX = (rightInput and 1 or 0) - (leftInput and 1 or 0)

  for entityId in pairs(self.minecartEntities) do
    for _, wheelJointId in ipairs(self.game:findDescendantComponents(entityId, "wheelJoint")) do
      local wheelJoint = assert(self.physicsDomain.wheelJoints[wheelJointId])
      wheelJoint:setMaxMotorTorque(5 * math.abs(inputX))
      wheelJoint:setMotorSpeed(10 * inputX)
    end
  end
end

return M
