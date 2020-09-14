local heart = require("heart")

local M = heart.class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)

  self.levelDomain = assert(self.engine.domains.level)
  self.physicsDomain = assert(self.engine.domains.physics)

  self.cameraComponents = assert(self.engine.componentManagers.camera)
  self.transformComponents = assert(self.engine.componentManagers.transform)
  self.viewportComponents = assert(self.engine.componentManagers.viewport)
end

function M:handleEvent(dt)
  local minPoint, maxPoint = unpack(self.levelDomain.bounds)

  local minX, minY = unpack(minPoint)
  local maxX, maxY = unpack(maxPoint)

  for playerId in pairs(self.engine.componentEntitySets.player) do
    local playerX, playerY = self.physicsDomain.bodies[playerId]:getPosition()

    for cameraId in pairs(self.engine.componentEntitySets.camera) do
      local transform = self.transformComponents:getTransform(cameraId)

      local cameraX, cameraY = transform:getPosition()

      local offsetX = playerX - cameraX
      local offsetY = playerY - cameraY

      local maxDistance = 0.5

      if offsetX * offsetX + offsetY * offsetY > maxDistance * maxDistance then
        local directionX, directionY = heart.math.normalize2(offsetX, offsetY)

        cameraX = playerX - maxDistance * directionX
        cameraY = playerY - maxDistance * directionY
      end

      local _, _, _, scaleX, scaleY = heart.math.decompose2(self.cameraComponents.transforms[cameraId])
      local scale = math.sqrt(math.abs(scaleX) * math.abs(scaleY))

      local viewportWidth, viewportHeight = unpack(
        self.viewportComponents.sizes[cameraId])

      local aspectRatio = viewportWidth / viewportHeight

      local clampedX, clampedY = heart.math.clamp2(
        cameraX, cameraY,
        minX + 0.5 * scale * aspectRatio, minY + 0.5 * scale,
        maxX - 0.5 * scale * aspectRatio, maxY - 0.5 * scale)

      self.transformComponents:setMode(cameraId, "world")
      transform:setTransform2(clampedX, clampedY)
      self.transformComponents:setDirty(cameraId, true)
    end
  end
end

return M
