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

local function clear(t, v)
  if v == nil then
    for k in pairs(t) do
      t[k] = nil
    end
  else
    for k, v2 in pairs(t) do
      if v2 == v then
        t[k] = nil
      end
    end
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

local function get(t, k, v)
  local v2 = t[k]

  if v2 == nil then
    return v
  end

  return v2
end

local function get2(t, k1, k2, v)
  t = t[k1]

  if t == nil then
    return v
  end

  local v2 = t[k2]

  if v2 == nil then
    return v
  end

  return v2
end

local function get3(t, k1, k2, k3, v)
  t = t[k1]

  if t == nil then
    return v
  end

  t = t[k2]

  if t == nil then
    return v
  end

  local v2 = t[k3]

  if v2 == nil then
    return v
  end

  return v2
end

local function set2(t, k1, k2, v)
  if v == nil then
    local t2 = t[k1]

    if t2 == nil then
      return
    end

    local v2 = t2[k2]

    if v2 == nil then
      return
    end

    t2[k2] = nil

    if next(t2) ~= nil then
      return
    end

    t[k1] = nil
  else
    local t2 = t[k1]

    if t2 == nil then
      t2 = {}
      t[k1] = t2
    end

    t2[k2] = v
  end
end

local function set3(t, k1, k2, k3, v)
  if v == nil then
    local t2 = t[k1]

    if t2 == nil then
      return
    end

    local t3 = t2[k2]

    if t3 == nil then
      return
    end

    local v2 = t3[k3]

    if v2 == nil then
      return
    end

    t3[k3] = nil

    if next(t3) ~= nil then
      return
    end

    t2[k2] = nil

    if next(t2) ~= nil then
      return
    end

    t[k1] = nil
  else
    local t2 = t[k1]

    if t2 == nil then
      t2 = {}
      t[k1] = t2
    end

    local t3 = t2[k2]

    if t3 == nil then
      t3 = {}
      t2[k2] = t3
    end

    t3[k3] = v
  end
end

return {
  clear = clear,
  get = get,
  get2 = get2,
  get3 = get3,
  keys = keys,
  removeArrayValues = removeArrayValues,
  set2 = set2,
  set3 = set3,
  values = values,
}
