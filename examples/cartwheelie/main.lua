local heart = require("heart")

function love.load()
  love.window.setTitle("Cartwheelie")

  love.window.setMode(800, 600, {
    fullscreentype = "desktop",
    resizable = true,
  })

  love.physics.setMeter(1)

  local resourceLoaders = {}
  local config = require("resources.levels.start")
  game = heart.Game.new(resourceLoaders, config)
end

function love.draw()
  game:handleEvent("draw")
end

function love.resize(width, height)
  game:handleEvent("resize", width, height)
end

function love.update(dt)
  game:handleEvent("update", dt)
end
