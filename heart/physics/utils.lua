local M = {}

function M.getLocalPoints(body, worldPoints, result)
  result = result or {}

  for i = 1, #worldPoints, 2 do
    result[#result + 1], result[#result + 2] =
      body:getLocalPoint(worldPoints[i], worldPoints[i + 1])
  end

  return result
end

return M
