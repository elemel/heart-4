local clamp = heart.math.clamp

local M = heart.class.newClass()

function M:init(game, config)
  self.game = assert(game)

  self.playerEntities = assert(self.game.componentEntitySets.player)
  self.positionComponents = assert(self.game.componentManagers.position)

  self.cameraEntities = assert(self.game.componentEntitySets.camera)
  self.cameraComponents = assert(self.game.componentManagers.camera)
  self.transformComponents = assert(self.game.componentManagers.transform)
  self.viewportComponents = assert(self.game.componentManagers.viewport)
end

function M:fixedUpdate(dt)
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
