local heart = require("heart")
local inverseKinematics = require("spider.inverseKinematics")

local M = heart.class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
end

function M:handleEvent(viewportId)
  local t = self.engine.domains.timer:getFraction()
  local transformComponents = self.engine.componentManagers.transform

  local distanceJoints = self.engine.domains.physics.distanceJoints
  local ropeJoints = self.engine.domains.physics.ropeJoints
  local circleFixtures = self.engine.domains.physics.circleFixtures

  local localJointNormals = self.engine.componentManagers.foot.localJointNormals
  local kneeDirections = self.engine.componentManagers.foot.kneeDirections
  local parents = self.engine.entityParents

  love.graphics.push("all")
  love.graphics.setColor(0.5, 0.5, 0.5, 1)

  for id, fixture in pairs(self.engine.domains.physics.polygonFixtures) do
    local transform = transformComponents:getInterpolatedTransform(id, t)
    local points = {fixture:getShape():getPoints()}

    for i = 1, #points, 2 do
      points[i], points[i + 1] = transform:transformPoint(points[i], points[i + 1])
    end

    love.graphics.polygon("fill", points)
  end

  for id in pairs(self.engine.componentEntitySets.ball) do
    local transform = transformComponents:getInterpolatedTransform(id, t)
    local x, y, angle = transform:getTransform2()
    local radius = circleFixtures[id]:getShape():getRadius()
    love.graphics.push()
    love.graphics.translate(x, y)
    love.graphics.rotate(angle)
    love.graphics.circle("fill", 0, 0, radius)
    love.graphics.pop()
  end

  love.graphics.pop()
  love.graphics.push()

  for id in pairs(self.engine.componentEntitySets.spider) do
    if ropeJoints[id] then
      local body1, body2 = ropeJoints[id]:getBodies()
      local x1, y1, x2, y2 = ropeJoints[id]:getAnchors()

      local transform1 = transformComponents:getInterpolatedTransform(body1:getUserData(), t)
      local transform2 = transformComponents:getInterpolatedTransform(body2:getUserData(), t)

      x1, y1 = transform1:transformPoint(body1:getLocalPoint(x1, y1))
      x2, y2 = transform2:transformPoint(body2:getLocalPoint(x2, y2))

      love.graphics.line(x1, y1, x2, y2)
    end
  end

  love.graphics.pop()

  love.graphics.push("all")
  love.graphics.setLineJoin("none")
  love.graphics.setLineWidth(0.125)

  love.graphics.setColor(0.75, 0.25, 0, 1)

  for id in pairs(self.engine.componentEntitySets.foot) do
    local legId = parents[id]

    local transform1 = transformComponents:getInterpolatedTransform(legId, t)
    local transform2 = transformComponents:getInterpolatedTransform(id, t)

    local x1, y1 = transform1:getPosition()
    local x2, y2 = transform2:getPosition()

    local direction = kneeDirections[id]

    local x, y = inverseKinematics.solve(x1, y1, x2, y2, 2, direction)
    love.graphics.line(x1, y1, x, y, x2, y2)

    love.graphics.circle("fill", x, y, 0.0625)
    love.graphics.circle("fill", x2, y2, 0.0625)
  end

  love.graphics.pop()

  love.graphics.push("all")
  love.graphics.setLineWidth(0.125)
  love.graphics.setColor(0.875, 0.375, 0, 1)

  for id in pairs(self.engine.componentEntitySets.spider) do
    local transform = transformComponents:getInterpolatedTransform(id, t)
    local x, y, angle = transform:getTransform2()

    love.graphics.push()
    love.graphics.translate(x, y)
    love.graphics.rotate(angle)

    love.graphics.line(-0.07315887075604807, -0.3677944801512114, -0.12193145126008012, -0.612990800252019)
    love.graphics.line(0.07315887075604807, -0.3677944801512114, 0.12193145126008012, -0.612990800252019)

    love.graphics.circle("fill", -0.12193145126008012, -0.612990800252019, 0.0625)
    love.graphics.circle("fill", 0.12193145126008012, -0.612990800252019, 0.0625)

    love.graphics.pop()
  end

  love.graphics.pop()

  love.graphics.push("all")

  for id in pairs(self.engine.componentEntitySets.spider) do
    local transform = transformComponents:getInterpolatedTransform(id, t)
    local x, y, angle = transform:getTransform2()

    love.graphics.push()
    love.graphics.translate(x, y)
    love.graphics.rotate(angle)

    -- love.graphics.setColor(1, 0.5, 0, 1)
    -- love.graphics.circle("fill", 0, 0, 0.5)

    -- love.graphics.setColor(0.875, 0.5, 0, 1)
    -- love.graphics.circle("fill", 0, 0.75, 0.5)

    love.graphics.push("all")
    love.graphics.setColor(0, 0, 0, 1)

    love.graphics.circle("fill", -0.07315887075604811, -0.3677944801512114, 0.0625)
    love.graphics.circle("fill", 0.07315887075604811, -0.3677944801512114, 0.0625)

    love.graphics.circle("fill", -0.20833883738235087, -0.31180110461345445, 0.046875)
    love.graphics.circle("fill", 0.20833883738235087, -0.31180110461345445, 0.046875)

    love.graphics.circle("fill", -0.048772580504032076, -0.2451963201008076, 0.03125)
    love.graphics.circle("fill", 0.048772580504032076, -0.2451963201008076, 0.03125)

    love.graphics.circle("fill", -0.13889255825490057, -0.20786740307563628, 0.03125)
    love.graphics.circle("fill", 0.13889255825490057, -0.20786740307563628, 0.03125)

    love.graphics.pop()

    love.graphics.pop()
  end

  love.graphics.pop()
end

return M
