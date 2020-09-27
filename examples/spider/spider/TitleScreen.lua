local heart = require("heart")

local M = heart.class.newClass()

function M:init()
  self.titleFont = love.graphics.newFont(64)
  self.textFont = love.graphics.newFont(32)
  self.titleText = love.graphics.newText(self.titleFont, "Spider")
  self.startText = love.graphics.newText(self.textFont, "Press any key to start")
end

function M:update(dt)
end

function M:draw()
  local windowWidth, windowHeight = love.graphics.getDimensions()
  local titleWidth, titleHeight = self.titleText:getDimensions()
  local startWidth, startHeight = self.startText:getDimensions()

  local titleX = math.floor(0.5 * windowWidth)
  local titleY = math.floor(0.25 * windowHeight)

  local titleOriginX = math.floor(0.5 * titleWidth)
  local titleOriginY = math.floor(0.5 * titleHeight)

  local startX = math.floor(0.5 * windowWidth)
  local startY = math.floor(0.75 * windowHeight)

  local startOriginX = math.floor(0.5 * startWidth)
  local startOriginY = math.floor(0.5 * startHeight)

  love.graphics.draw(self.titleText, titleX, titleY, 0, 1, 1, titleOriginX, titleOriginY)
  love.graphics.draw(self.startText, startX, startY, 0, 1, 1, startOriginX, startOriginY)
end

function M:resize(w, h)
end

function M:keypressed(key, scancode, isrepeat)
  local GameScreen = require("spider.GameScreen")
  screen = GameScreen.new()
end

return M
