local class = require("heart.class")

local RiderFixedUpdateSystem = class.newClass()

local function getOtherBody(joint, body)
  local body1, body2 = joint:getBodies()
  return body == body1 and body2 or body1
end

function RiderFixedUpdateSystem:init(game, config)
  self.game = assert(game)
  self.physicsDomain = assert(self.game.domains.physics)
  self.riderEntities = assert(self.game.componentEntitySets.rider)
end

function RiderFixedUpdateSystem:fixedUpdate(dt)
  local world = self.physicsDomain.world
  local bodies = self.physicsDomain.bodies
  local motorJoints = self.physicsDomain.motorJoints

  local leftInput = love.keyboard.isDown("a")
  local rightInput = love.keyboard.isDown("d")
  local upInput = love.keyboard.isDown("w")
  local downInput = love.keyboard.isDown("s")

  local inputX = (rightInput and 1 or 0) - (leftInput and 1 or 0)
  local inputY = (downInput and 1 or 0) - (upInput and 1 or 0)

  for entityId in pairs(self.riderEntities) do
    local body = bodies[entityId]
    local x1, y1 = body:getPosition()
    local x2, y2 = x1, y1 + 1.2
    local hitBody, hitX, hitY

    function callback(fixture, x, y, xn, yn, fraction)
      if fixture:getGroupIndex() ~= -1 and not fixture:isSensor() then
        hitBody = fixture:getBody()
        hitX = x
        hitY = y
        return fraction
      else
        return 1
      end
    end

    world:rayCast(x1, y1, x2, y2, callback)

    local joint = motorJoints[entityId]
    local groundBody = joint and getOtherBody(joint, body)

    if hitBody ~= groundBody then
      if joint then
        self.game:destroyComponent(entityId, "motorJoint")
        joint = nil
      end

      groundBody = hitBody

      if groundBody then
        joint = self.game:createComponent(entityId, "motorJoint", {
          body1 = groundBody:getUserData(),
          body2 = entityId,
          collideConnected = true,
          maxForce = 30,
          maxTorque = 10,
        })
      end
    end

    if joint then
      local x, y = hitX, hitY
      local angularOffset = 0
      local walkSpeed = 2

      if inputY ~= 1 then
        x = x + inputX * walkSpeed * dt / 0.3
        y = y - 1.15
      else
        x = x + 0.5 * inputX * walkSpeed * dt / 0.3
        y = y - 0.6
        angularOffset = 0.25 * math.pi
      end

      x, y = groundBody:getLocalPoint(x, y)
      angularOffset = angularOffset - groundBody:getAngle()

      joint:setLinearOffset(x, y)
      joint:setAngularOffset(angularOffset)

    end
  end
end

return RiderFixedUpdateSystem
