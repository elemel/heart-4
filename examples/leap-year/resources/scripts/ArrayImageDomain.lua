local ArrayImageDomain = heart.class.newClass()

function ArrayImageDomain:init(game, config)
  local filenames = require("resources.images.simplesPimples")
  self.image = love.graphics.newArrayImage(filenames)

  self.layerNames = {}
  self.layerIndices = {}

  for i, filename in ipairs(filenames) do
    local name = filename:match("^.+/(.+)%..+$")
    self.layerNames[i] = name
    self.layerIndices[name] = i
  end
end

return ArrayImageDomain
