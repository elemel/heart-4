local max = math.max

local M = {}

function M.boxDistance(x1, y1, x2, y2, x3, y3, x4, y4)
  if max(x1 - x4, x3 - x2) > max(y1 - y4, y3 - y2) then
    if x1 - x4 > x3 - x2 then
      return x1 - x4, -1, 0, "left"
    else
      return x3 - x2, 1, 0, "right"
    end
  else
    if y1 - y4 > y3 - y2 then
      return y1 - y4, 0, -1, "up"
    else
      return y3 - y2, 0, 1, "down"
    end
  end
end

return M
