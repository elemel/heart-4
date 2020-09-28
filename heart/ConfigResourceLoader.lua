local class = require("heart.class")
local config = require("heart.config")

local M = class.newClass()

function M:init()
  self.configs = {}
end

function M:loadResource(filename)
  if not self.configs[filename] then
    self.configs[filename] = config.expand(require(filename))
  end

  return M.configs[filename]
end

return M
