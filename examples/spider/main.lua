local heart = require("heart")

function love.load()
  love.window.setTitle("Spider")

  love.window.setMode(800, 600, {
    resizable = true,
  })

  love.physics.setMeter(1)

  local resourceLoaders = {}
  local config = require("resources.level")
  engine = heart.Engine.new(resourceLoaders, config)
end

function love.update(dt)
  engine:handleEvent("update", dt)
end

function love.draw()
  engine:handleEvent("draw")
end

function love.resize(w, h)
  engine:handleEvent("resize", w, h)
end
