local class = require("heart.class")

local ImageResourceLoader = class.newClass()

function ImageResourceLoader:init()
  self.images = {}
end

function ImageResourceLoader:loadResource(filename)
  local image = self.images[filename]

  if not image then
    -- print("Loading image: " .. filename)
    image = love.graphics.newImage(filename)
    self.images[filename] = image
  end

  return image
end

return ImageResourceLoader
