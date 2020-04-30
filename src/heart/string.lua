local M = {}

function M.split(s, sep, t)
  t = t or {}
  local i = 1

  while true do
    local j, k = string.find(s, sep, i, false)

    if j == nil then
      table.insert(t, string.sub(s, i))
      break
    end

    table.insert(t, string.sub(s, i, j - 1))
    i = k + 1
  end

  return t
end

-- http://lua-users.org/wiki/StringTrim
function M.strip(s)
   return s:gsub("^%s*(.-)%s*$", "%1")
end

return M
