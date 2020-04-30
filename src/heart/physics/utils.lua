local M = {}

function M.getLocalPoints(body, worldPoints, localPoints)
  localPoints = localPoints or {}
  local getLocalPoint = body.getLocalPoint

  for i = 1, #worldPoints, 2 do
    localPoints[#localPoints + 1], localPoints[#localPoints + 2] =
      getLocalPoint(body, worldPoints[i], worldPoints[i + 1])
  end

  return localPoints
end

return M
