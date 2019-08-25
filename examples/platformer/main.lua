heart = require("heart")

local palette = require("resources.scripts.palette")

function love.load()
  love.window.setTitle("Platformer")

  love.window.setMode(800, 600, {
    fullscreentype = "desktop",
    resizable = true,
    fullscreen = true,
    highdpi = true,
  })

  love.graphics.setDefaultFilter("linear", "nearest")
  love.physics.setMeter(1)
  love.mouse.setVisible(false)

  love.graphics.setBackgroundColor(heart.svg.parseColor(palette.lightBlue))

  local resourceLoaders = {
    image = heart.graphics.ImageResourceLoader.new(),
  }

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
