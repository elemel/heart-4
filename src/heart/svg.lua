local heartString = require("heart.string")

local svg = {}

function svg.parseStyle(s)
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

function svg.parseColor(s)
  if s:sub(1, 4) == "rgb(" and s:sub(-1) == ")" then
    rgbStrings = heartString.split(s:sub(5, -2), ",")

    return tonumber(rgbStrings[1]) / 255,
      tonumber(rgbStrings[2]) / 255,
      tonumber(rgbStrings[3]) / 255
  end

  s = s:gsub("#", "")

  return tonumber("0x" .. s:sub(1, 2)) / 255,
    tonumber("0x" .. s:sub(3, 4)) / 255,
    tonumber("0x" .. s:sub(5,6)) / 255
end

function svg.parsePath(s)
  local path = {}

  string.gsub(s, "([-%d.]+) ([-%d.]+)", function (x, y)
    table.insert(path, x)
    table.insert(path, y)
  end)

  return path
end

function svg.findElement(t, k, v)
  if t.xarg and t.xarg[k] == v then
    return t
  end

  for i, child in ipairs(t) do
    if type(child) == "table" then
      local element = svg.findElement(child, k, v)

      if element then
        return element
      end
    end
  end

  return nil
end

return svg
