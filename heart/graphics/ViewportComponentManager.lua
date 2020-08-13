local class = require("heart.class")

local M = class.newClass()

function M:init(engine, config)
  self.xs = {}
  self.ys = {}
  self.widths = {}
  self.heights = {}
end

function M:createComponent(entityId, config)
  self.xs[entityId] = config.x or 0
  self.ys[entityId] = config.y or 0
  self.widths[entityId] = config.width or 800
  self.heights[entityId] = config.height or 600
end

function M:destroyComponent(entityId)
  self.heights[entityId] = nil
  self.widths[entityId] = nil
  self.ys[entityId] = nil
  self.xs[entityId] = nil
end

return M
