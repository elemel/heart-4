local class = require("heart.class")

local M = class.newClass()

function M:init(engine, config)
  local gravityX = config.gravityX or 0
  local gravityY = config.gravityY or 0
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
