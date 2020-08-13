local heart = require("heart")

function love.load()
  love.window.setTitle("Cartwheelie")

  love.window.setMode(800, 600, {
    fullscreentype = "desktop",
    resizable = true,
    msaa = 4,
  })

  love.graphics.setDefaultFilter("linear", "nearest")
  love.physics.setMeter(1)

  local resourceLoaders = {
    image = heart.graphics.ImageResourceLoader.new(),
    mesh = heart.graphics.MeshResourceLoader.new(),
  }

  local config = require("cartwheelie.resources.configs.game")
  engine = heart.Engine.new(resourceLoaders, config)
end

function love.draw()
  engine:handleEvent("draw")
end

function love.resize(width, height)
  engine:handleEvent("resize", width, height)
end

function love.update(dt)
  engine:handleEvent("update", dt)
end
