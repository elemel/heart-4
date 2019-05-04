local class = require("heart.class")

local ImageResourceLoader = class.newClass()

function ImageResourceLoader:init()
  self.images = {}
end

function ImageResourceLoader:load(filename)
  local image = self.images[filename]

  if not image then
    image = love.graphics.newImage(filename)
    self.images[filename] = image
  end

  return image
end

return ImageResourceLoader
