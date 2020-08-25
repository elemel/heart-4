local class = require("heart.class")

local M = class.newClass()

function M:init(engine, config)
  self.positions = {}
  self.sizes = {}
end

function M:createComponent(id, config)
  self.positions[id] = {unpack(config.position or {0, 0})}
  self.sizes[id] = {unpack(config.size or {800, 600})}
end

function M:destroyComponent(id)
  self.positions[id] = nil
  self.sizes[id] = nil
end

return M
