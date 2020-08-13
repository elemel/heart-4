local floor = math.floor
local set3 = heart.table.set3

local M = heart.class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)

  self.positionComponents = assert(self.engine.componentManagers.position)
  self.boxComponents = assert(self.engine.componentManagers.box)

  self.minXs = {}
  self.minYs = {}

  self.maxXs = {}
  self.maxYs = {}

  self.grid = {}
  self.constraintMaps = {}
end

function M:createComponent(id, config)
  local x = self.positionComponents.xs[id]
  local y = self.positionComponents.ys[id]

  local width = self.boxComponents.widths[id]
  local height = self.boxComponents.heights[id]

  local minX = floor(x - 0.5 * width)
  local minY = floor(y - 0.5 * height)

  local maxX = floor(x + 0.5 * width)
  local maxY = floor(y + 0.5 * height)

  self.minXs[id] = minX
  self.minYs[id] = minY

  self.maxXs[id] = maxX
  self.maxYs[id] = maxY

  local grid = self.grid

  for y2 = minY, maxY do
    for x2 = minX, maxX do
      set3(grid, y2, x2, id, true)
    end
  end

  self.constraintMaps[id] = {}
end

function M:destroyComponent(id)
  self.constraintMaps[id] = nil

  local grid = self.grid

  local minX = self.minXs[id]
  local minY = self.minYs[id]

  local maxX = self.maxXs[id]
  local maxY = self.maxYs[id]

  for y = minY, maxY do
    for x = minX, maxX do
      set3(grid, y, x, id, nil)
    end
  end

  self.minXs[id] = nil
  self.minYs[id] = nil

  self.maxXs[id] = nil
  self.maxYs[id] = nil
end

function M:updateCells(id)
  local grid = self.grid

  local x = self.positionComponents.xs[id]
  local y = self.positionComponents.ys[id]

  local width = self.boxComponents.widths[id]
  local height = self.boxComponents.heights[id]

  local minX = floor(x - 0.5 * width)
  local minY = floor(y - 0.5 * height)

  local maxX = floor(x + 0.5 * width)
  local maxY = floor(y + 0.5 * height)

  local oldMinX = self.minXs[id]
  local oldMinY = self.minYs[id]

  local oldMaxX = self.maxXs[id]
  local oldMaxY = self.maxYs[id]

  if minX ~= oldMinX or minY ~= oldMinY or maxX ~= oldMaxX or maxY ~= oldMaxY then
    for y2 = oldMinY, oldMaxY do
      for x2 = oldMinX, oldMaxX do
        if x2 < minX or x2 > maxX or y2 < minY or y2 > maxY then
          set3(grid, y2, x2, id, nil)
        end
      end
    end

    for y2 = minY, maxY do
      for x2 = minX, maxX do
        if x2 < oldMinX or x2 > oldMaxX or y2 < oldMinY or y2 > oldMaxY then
          set3(grid, y2, x2, id, true)
        end
      end
    end

    self.minXs[id] = minX
    self.minYs[id] = minY

    self.maxXs[id] = maxX
    self.maxYs[id] = maxY
  end
end

return M
