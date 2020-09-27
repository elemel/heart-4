local heart = require("heart")

local mix2 = heart.math.mix2

local M = heart.class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
end

function M:handleEvent(dt)
  local distanceJoints = self.engine.domains.physics.distanceJoints
  local transformComponents = self.engine.componentManagers.transform
  local localJointNormals = self.engine.componentManagers.foot.localJointNormals
  local kneeDirections = self.engine.componentManagers.foot.kneeDirections
  local restKneeDirections = self.engine.componentManagers.foot.restKneeDirections
  local restLocalPositions = self.engine.componentManagers.foot.restLocalPositions

  for id in pairs(self.engine.componentEntitySets.foot) do
    if distanceJoints[id] then
      local body1, body2 = distanceJoints[id]:getBodies()
      local x1, y1, x2, y2 = distanceJoints[id]:getAnchors()
      local transform2 = transformComponents:getTransform(body2:getUserData())

      local offsetX = x2 - x1
      local offsetY = y2 - y1

      local localNormal = localJointNormals[id]
      local footNormalX, footNormalY = transform2:transformVector(localNormal[1], localNormal[2])

      kneeDirections[id] = (offsetX * footNormalY < footNormalX * offsetY) and 1 or -1

      transformComponents:setMode(id, "world")
      transformComponents.transforms[id]:setTransform2(x2, y2)
      transformComponents:setDirty(id, true)
    else
      kneeDirections[id] = restKneeDirections[id]

      local x, y = transformComponents.localTransforms[id]:getPosition()

      local targetX = restLocalPositions[id][1]
      local targetY = restLocalPositions[id][2]

      x, y = mix2(x, y, targetX, targetY, 0.0625)

      transformComponents.localTransforms[id]:setTransform2(x, y)
      transformComponents:setDirty(id, true)
    end
  end
end

return M
