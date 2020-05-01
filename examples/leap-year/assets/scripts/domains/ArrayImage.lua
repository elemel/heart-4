local filenames = require("assets.scripts.arrayImage")

local M = heart.class.newClass()

function M:init(game, config)
  self.image = love.graphics.newArrayImage(filenames)

  self.layerNames = {}
  self.layerIndices = {}

  for i, filename in ipairs(filenames) do
    local name = filename:match("^.+/(.+)%..+$")
    self.layerNames[i] = name
    self.layerIndices[name] = i
  end
end

return M
