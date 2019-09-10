heart = require("heart")

local palette = require("resources.scripts.palette")

function love.load()
  love.window.setTitle("Leap Year")

  love.window.setMode(800, 600, {
    fullscreentype = "desktop",
    resizable = true,
    -- fullscreen = true,
    highdpi = true,
  })

  love.graphics.setDefaultFilter("linear", "nearest")
  love.physics.setMeter(1)
  love.mouse.setVisible(false)

  local r1, g1, b1 = heart.svg.parseColor(palette.lightBlue)
  local r2, g2, b2 = heart.svg.parseColor(palette.brightBlue)

  backgroundMesh = love.graphics.newMesh({
    {0, 0, 0, 0, r1, g1, b1, 1},
    {1, 0, 0, 0, r1, g1, b1, 1},
    {1, 1, 0, 0, r2, g2, b2, 1},
    {0, 1, 0, 0, r2, g2, b2, 1},
  })

  local resourceLoaders = {
    image = heart.graphics.ImageResourceLoader.new(),
  }

  local config = require("resources.levels.mountain")
  game = heart.Game.new(resourceLoaders, config)
end

function love.draw()
  local width, height = love.graphics.getDimensions()
  love.graphics.draw(backgroundMesh, 0, 0, 0, width, height)

  game:handleEvent("draw")
end

function love.resize(width, height)
  game:handleEvent("resize", width, height)
end

function love.update(dt)
  game:handleEvent("update", dt)
end
