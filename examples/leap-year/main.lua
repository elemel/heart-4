heart = require("heart")

local levelGrid = require("leapYear.resources.configs.levelGrid")

function love.load()
  love.window.setTitle("Leap Year")

  love.window.setMode(800, 600, {
    fullscreentype = "desktop",
    resizable = true,
    -- fullscreen = true,
    -- highdpi = true,
  })

  love.graphics.setDefaultFilter("linear", "nearest")
  love.physics.setMeter(1)
  love.mouse.setVisible(false)

  local resourceLoaders = {
    image = heart.graphics.ImageResourceLoader.new(),
  }

  local gameConfig = require("leapYear.resources.configs.game")
  local levelConfig = require("leapYear.resources.configs.levels.forest")
  local config = setmetatable({entities = levelConfig}, {__index = gameConfig})
  engine = heart.Engine.new(resourceLoaders, config)

  love.handlers.warp = love.warp

  love.event.push("warp", {a = "b"})
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

function love.warp(levelX, levelY, entityConfigs)
end
