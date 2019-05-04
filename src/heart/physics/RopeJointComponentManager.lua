local class = require("heart.class")
local mathUtils = require("heart.math.utils")

local RopeJointComponentManager = class.newClass()

function RopeJointComponentManager:init(game, config)
  self.game = assert(game)
  self.physicsDomain = assert(self.game.domains.physics)
end

function RopeJointComponentManager:createComponent(entityId, config, transform)
  local bodyId2 = config.body2 or "body"

  if type(bodyId2) == "string" then
    bodyId2 = self.game:findAncestorComponent(entityId, bodyId2)
  end

  local bodyId1 = config.body1 or "body"

  if type(bodyId1) == "string" then
    bodyId1 = self.game:findAncestorComponent(bodyId2, bodyId1, 1)
  end

  local body1 = self.physicsDomain.bodies[bodyId1]
  local body2 = self.physicsDomain.bodies[bodyId2]
  local x1 = config.x1 or 0
  local y1 = config.y1 or 0
  x1, y1 = transform:transformPoint(x1, y1)
  local x2 = config.x2 or 0
  local y2 = config.y2 or 0
  x2, y2 = transform:transformPoint(x2, y2)
  local maxLength = config.maxLength or 1
  local collideConnected = config.collideConnected == true

  local joint =
    love.physics.newRopeJoint(
      body1, body2, x1, y1, x2, y2, maxLength, collideConnected)

  joint:setUserData(entityId)
  self.physicsDomain.ropeJoints[entityId] = joint
  return joint
end

function RopeJointComponentManager:destroyComponent(entityId)
  self.physicsDomain.ropeJoints[entityId]:destroy()
  self.physicsDomain.ropeJoints[entityId] = nil
end

return RopeJointComponentManager
