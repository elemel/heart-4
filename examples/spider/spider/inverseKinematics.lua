local sqrt = math.sqrt

local M = {}

function M.solve(x1, y1, x2, y2, length)
  local midX = 0.5 * (x1 + x2)
  local midY = 0.5 * (y1 + y2)

  local squaredDistance = (x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1)

  if squaredDistance == 0 then
    return midX, midY
  end

  local squaredDoubleOffset = length * length - squaredDistance

  if squaredDoubleOffset <= 0 then
    return midX, midY
  end

  local distance = sqrt(squaredDistance)

  local tangentX = (x2 - x1) / distance
  local tangentY = (y2 - y1) / distance

  local normalX = tangentY
  local normalY = -tangentX

  local offset = 0.5 * sqrt(squaredDoubleOffset)

  local x = midX + offset * normalX
  local y = midY + offset * normalY

  return x, y
end

return M
