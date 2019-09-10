local BoxDebugDrawSystem = heart.class.newClass()

function BoxDebugDrawSystem:init(game, config)
  self.game = assert(game)
  self.boxEntities = assert(self.game.componentEntitySets.box)

  self.positionComponents = assert(self.game.componentManagers.position)
  self.boxComponents = assert(self.game.componentManagers.box)
end

function BoxDebugDrawSystem:debugDraw(viewportId)
  local xs = self.positionComponents.xs
  local ys = self.positionComponents.ys

  local widths = self.boxComponents.widths
  local heights = self.boxComponents.heights

  for id in pairs(self.boxEntities) do
    local x = xs[id]
    local y = ys[id]

    local width = widths[id]
    local height = heights[id]

    love.graphics.rectangle("line", x - 0.5 * width, y - 0.5 * height, width, height)
  end
end

return BoxDebugDrawSystem
