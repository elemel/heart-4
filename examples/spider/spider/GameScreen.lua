local heart = require("heart")

local M = heart.class.newClass()

function M:init()
  local resourceLoaders = {
    image = heart.graphics.ImageResourceLoader.new()
  }

  local config = heart.config.expand(require("resources.levels.spring"))
  self.engine = heart.Engine.new(resourceLoaders, config)
end

function M:update(dt)
  self.engine:handleEvent("update", dt)
end

function M:draw()
  self.engine:handleEvent("draw")
end

function M:resize(w, h)
  self.engine:handleEvent("resize", w, h)
end

function M:keypressed(key, scancode, isrepeat)
  self.engine:handleEvent("keypressed", key, scancode, isrepeat)
end

return M
