local heartString = require("heart.string")

local M = {}

function M.parseStyle(s)
  local style = {}
  local attrs = heartString.split(s, ";")

  for i, attr in ipairs(attrs) do
    attr = heartString.strip(attr)

    if #attr > 0 then
      local k, v = unpack(heartString.split(attr, ":"))
      k = heartString.strip(k)
      v = heartString.strip(v)
      style[k] = v
    end
  end

  return style
end

function M.parseColor(s)
  if s:sub(1, 4) == "rgb(" and s:sub(-1) == ")" then
    local rgbStrings = heartString.split(s:sub(5, -2), ",")

    return tonumber(rgbStrings[1]) / 255,
      tonumber(rgbStrings[2]) / 255,
      tonumber(rgbStrings[3]) / 255
  end

  s = s:gsub("#", "")

  return tonumber("0x" .. s:sub(1, 2)) / 255,
    tonumber("0x" .. s:sub(3, 4)) / 255,
    tonumber("0x" .. s:sub(5,6)) / 255
end

function M.parsePath(s)
  local path = {}

  string.gsub(s, "([A-Za-z])([^A-Za-z]*)", function (command, params)
    local instruction = {command}

    string.gsub(params, "([-%d.]+)", function (param)
      table.insert(instruction, tonumber(param))
    end)

    table.insert(path, instruction)
  end)

  return path
end

function M.renderPath(path, depth)
  depth = depth or 5
  local polygon = {}

  for i, instruction in ipairs(path) do
    if #instruction >= 3 then
      command, x2, y2, x3, y3, x4, y4 = unpack(instruction)

      if command == "C" then
        local x1 = polygon[#polygon - 1]
        local y1 = polygon[#polygon]
        local n = 2 ^ depth

        for i = 1, n - 1 do
          local x, y = M.evaluateCubic(x1, y1, x2, y2, x3, y3, x4, y4, i / n)
          table.insert(polygon, x)
          table.insert(polygon, y)
        end

        table.insert(polygon, x4)
        table.insert(polygon, y4)
      else
        table.insert(polygon, instruction[#instruction - 1])
        table.insert(polygon, instruction[#instruction])
      end
    end
  end

  return polygon
end

function M.evaluateCubic(x1, y1, x2, y2, x3, y3, x4, y4, t)
  local t1 = (1 - t) * (1 - t) * (1 - t)
  local t2 = 3 * (1 - t) * (1 - t) * t
  local t3 = 3 * (1 - t) * t * t
  local t4 = t * t * t

  local x = t1 * x1 + t2 * x2 + t3 * x3 + t4 * x4
  local y = t1 * y1 + t2 * y2 + t3 * y3 + t4 * y4

  return x, y
end

function M.findElement(t, k, v)
  if t.attributes and t.attributes[k] == v then
    return t
  end

  for i, child in ipairs(t) do
    if type(child) == "table" then
      local element = M.findElement(child, k, v)

      if element then
        return element
      end
    end
  end

  return nil
end

return M
