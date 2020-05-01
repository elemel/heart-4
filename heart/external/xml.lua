-- Adapted from: http://lua-users.org/wiki/LuaXml

local xml = {}

local function parseAttributes(s)
  local attributes = {}

  string.gsub(s, "([%-%w:]+)%s*=%s*([\"'])(.-)%2", function (name, quote, value)
    attributes[name] = value
  end)

  return attributes
end
    
function xml.parseDocument(s)
  local stack = {{}}
  local i = 1
  local line = 1

  while true do
    local j, k, endSlash, name, attributesString, emptySlash =
      string.find(s, "<(%/?)([%-%w:]+)(.-)(%/?)>", i)

    if not j then
      break
    end

    local text = string.sub(s, i, j - 1)

    for newline in string.gmatch(text, "\n") do
      line = line + 1
    end

    if not string.find(text, "^%s*$") then
      table.insert(stack[#stack], text)
    end

    if endSlash == "/" then
      if #stack == 1 then
        error("Missing start tag for end tag: " .. name)
      end

      if stack[#stack].name ~= name then
        error(
          "End tag \"" .. name ..
          "\" does not match start tag \"" .. stack[#stack].name .. "\"")
      end

      local element = table.remove(stack)
      table.insert(stack[#stack], element)
    else
      local attributes = parseAttributes(attributesString)

      local element = {
        name = name,
        attributes = attributes,
        line = line,
      }

      for newline in string.gmatch(attributesString, "\n") do
        line = line + 1
      end

      if emptySlash == "/" then
        table.insert(stack[#stack], element)
      else
        table.insert(stack, element)
      end
    end

    i = k + 1
  end

  local text = string.sub(s, i)

  if not string.find(text, "^%s*$") then
    table.insert(stack[#stack], text)
  end

  if #stack > 1 then
    error("Missing end tag for start tag: " .. stack[#stack].name)
  end

  return stack[1]
end

return xml
