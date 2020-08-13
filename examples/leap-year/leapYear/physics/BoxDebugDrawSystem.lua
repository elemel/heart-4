local M = heart.class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.boxEntities = assert(self.engine.componentEntitySets.box)

  self.positionComponents = assert(self.engine.componentManagers.position)
  self.boxComponents = assert(self.engine.componentManagers.box)
end

function M:handleEvent(viewportId)
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

return M
