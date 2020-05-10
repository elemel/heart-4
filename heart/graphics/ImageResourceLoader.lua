local class = require("heart.class")

local M = class.newClass()

function M:init()
  self.images = {}
end

function M:loadResource(filename)
  local image = self.images[filename]

  if not image then
    -- print("Loading image: " .. filename)
    image = love.graphics.newImage(filename)
    self.images[filename] = image
  end

  return image
end

return M
