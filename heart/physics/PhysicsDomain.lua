local class = require("heart.class")

local M = class.newClass()

function M:init(engine, config)
  if config.gravityX or config.gravityY then
    print("Deprecated physics config")
  end

  local gravityX = config.gravityX or 0
  local gravityY = config.gravityY or 0

  if config.gravity then
    gravityX = config.gravity[1] or 0
    gravityY = config.gravity[2] or 0
  end

  local sleepingAllowed = config.sleepingAllowed ~= false

  self.world = love.physics.newWorld(gravityX, gravityY, sleepingAllowed)
  self.bodies = {}

  self.chainFixtures = {}
  self.circleFixtures = {}
  self.polygonFixtures = {}
  self.rectangleFixtures = {}

  self.distanceJoints = {}
  self.frictionJoints = {}
  self.motorJoints = {}
  self.revoluteJoints = {}
  self.ropeJoints = {}
  self.wheelJoints = {}
end

return M
