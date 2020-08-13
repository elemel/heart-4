local clamp = heart.math.clamp

local M = heart.class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)

  self.cameraEntities = assert(self.engine.componentEntitySets.camera)
  self.playerEntities = assert(self.engine.componentEntitySets.player)

  self.positionComponents = assert(self.engine.componentManagers.position)
  self.transformComponents = assert(self.engine.componentManagers.transform)
  self.viewportComponents = assert(self.engine.componentManagers.viewport)
end

function M:handleEvent(dt)
  local playerCount = 0
  local totalX = 0
  local xs = self.positionComponents.xs

  for playerId in pairs(self.playerEntities) do
    local x = xs[playerId]
    playerCount = playerCount + 1
    totalX = totalX + x
  end

  if playerCount >= 1 then
    local x = totalX / playerCount

    local transforms = self.transformComponents.transforms

    local widths = self.viewportComponents.widths
    local heights = self.viewportComponents.heights

    for cameraId in pairs(self.cameraEntities) do
      local width = widths[cameraId]
      local height = heights[cameraId]

      local minX = 0.5 * 16 * width / height
      local clampedX = clamp(x, minX, 64 - minX)

      transforms[cameraId]:setTransformation(clampedX, 8, 0, 16)
    end
  end
end

return M
