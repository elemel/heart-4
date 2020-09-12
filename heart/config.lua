local M = {}

function M.preprocess(config)
  local result = config

  if type(config) == "table" then
    result = {}
    for k, v in pairs(config) do
    end
  end

  return result
end

return M
