local class = require("heart.class")

local PhysicsDomain = class.newClass()

function PhysicsDomain:init(game, config)
  local gravityX = config.gravityX or 0
  local gravityY = config.gravityY or 0
  local sleepingAllowed = config.sleepingAllowed ~= false
  self.world = love.physics.newWorld(gravityX, gravityY, sleepingAllowed)
  self.bodies = {}
  self.circleFixtures = {}
  self.rectangleFixtures = {}
  self.chainFixtures = {}
  self.wheelJoints = {}
  self.revoluteJoints = {}
  self.motorJoints = {}
  self.ropeJoints = {}
end

return PhysicsDomain
