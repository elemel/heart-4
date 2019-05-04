local function newClass()
  local class = {}
  class.__index = class

  function class.new(...)
    local instance = setmetatable({}, class)
    instance:init(...)
    return instance
  end

  return class
end

return {
  newClass = newClass,
}
