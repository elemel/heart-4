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
  local jointAnchors = self.engine.componentManagers.leg.jointAnchors
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

  love.graphics.pop()

  love.graphics.push("all")
  love.graphics.setLineJoin("none")
  love.graphics.setLineWidth(0.0625)

  love.graphics.setColor(0.75, 0.25, 0, 1)

  for id in pairs(self.engine.componentEntitySets.leg) do
    if distanceJoints[id] then
      local spiderId = parents[id]
      local spiderTransform = transformComponents:getInterpolatedTransform(spiderId, t)
      local spiderX, spiderY = spiderTransform:getPosition()

      local hipTransform = transformComponents:getInterpolatedTransform(id, t)
      local hipX, hipY = hipTransform:getPosition()

      local anchor = jointAnchors[id]
      local anchorTransform = transformComponents:getInterpolatedTransform(anchor.bodyId, t)
      local footX, footY = anchorTransform:transformPoint(anchor.localPosition[1], anchor.localPosition[2])
      local footNormalX, footNormalY = anchorTransform:transformVector(anchor.localNormal[1], anchor.localNormal[2])

      local offsetX = footX - hipX
      local offsetY = footY - hipY

      local kneeX = 0
      local kneeY = 0

      if offsetX * footNormalY < footNormalX * offsetY then
        kneeX, kneeY = inverseKinematics.solve(hipX, hipY, footX, footY, 2)
      else
        kneeX, kneeY = inverseKinematics.solve(footX, footY, hipX, hipY, 2)
      end

      love.graphics.line(spiderX, spiderY, hipX, hipY, kneeX, kneeY, footX, footY)

      love.graphics.circle("fill", hipX, hipY, 0.03125)
      love.graphics.circle("fill", kneeX, kneeY, 0.03125)
      love.graphics.circle("fill", footX, footY, 0.03125)
    end
  end

  love.graphics.pop()
  love.graphics.push("all")

  for id in pairs(self.engine.componentEntitySets.spider) do
    local transform = transformComponents:getInterpolatedTransform(id, t)
    local x, y, angle = transform:getTransform2()

    local sightX, sightY = transform:transformPoint(0, -10)

    love.graphics.setColor(1, 0, 0, 0.25)
    love.graphics.line(x, y, sightX, sightY)

    love.graphics.setColor(1, 0.5, 0, 1)

    love.graphics.push()
    love.graphics.translate(x, y)
    love.graphics.rotate(angle)
    love.graphics.circle("fill", 0, 0, 0.5 + 0.03125)
    love.graphics.circle("fill", 0, -0.5, 0.25)
    love.graphics.pop()
  end

  love.graphics.pop()
end

return M
