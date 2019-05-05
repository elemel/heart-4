local class = require("heart.class")

local ViewportComponentManager = class.newClass()

function ViewportComponentManager:init(game, config)
  self.xs = {}
  self.ys = {}
  self.widths = {}
  self.heights = {}
end

function ViewportComponentManager:createComponent(entityId, config, transform)
  self.xs[entityId] = config.x or 0
  self.ys[entityId] = config.y or 0
  self.widths[entityId] = config.width or 800
  self.heights[entityId] = config.height or 600
end

function ViewportComponentManager:destroyComponent(entityId)
  self.heights[entityId] = nil
  self.widths[entityId] = nil
  self.ys[entityId] = nil
  self.xs[entityId] = nil
end

return ViewportComponentManager
