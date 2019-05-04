local function removeArrayValues(t, v)
  local n = 0

  for i, v2 in ipairs(t) do
    if v2 ~= v then
      n = n + 1
      t[n] = v2
    end
  end

  while #t > n do
    t[#t] = nil
  end
end

local function clear(t)
  for k in pairs(t) do
    t[k] = nil
  end
end

local function clearArray(t)
  while #t > 0 do
    t[#t] = nil
  end
end

local function keys(t, ks)
  ks = ks or {}

  for k in pairs(t) do
    ks[#ks + 1] = k
  end

  return ks
end

local function values(t, vs)
  vs = vs or {}

  for k, v in pairs(t) do
    vs[#vs + 1] = v
  end

  return vs
end

return {
  clear = clear,
  clearArray = clearArray,
  keys = keys,
  removeArrayValues = removeArrayValues,
  values = values,
}
