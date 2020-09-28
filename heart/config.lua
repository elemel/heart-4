local M = {}

function M.expand(config, loadConfig, result)
  loadConfig = loadConfig or require
  result = result or {}

  if config.prototype then
    local prototype = loadConfig(config.prototype)

    for k, v in pairs(prototype) do
      if type(v) == "table" then
        if type(result[k]) ~= "table" then
          result[k] = {}
        end

        expand(v, loadConfig, result[k])
      else
        result[k] = v
      end
    end
  end

  for k, v in pairs(config) do
    if type(v) == "table" then
      if type(result[k]) ~= "table" then
        result[k] = {}
      end

      expand(v, loadConfig, result[k])
    else
      result[k] = v
    end
  end

  return result
end


return M
