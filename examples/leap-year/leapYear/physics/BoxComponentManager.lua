local M = heart.class.newClass()

function M:init(engine, config)
  self.widths = {}
  self.heights = {}
end

function M:createComponent(id, config)
  self.widths[id] = config.width or 1
  self.heights[id] = config.height or 1
end

function M:destroyComponent(id)
  self.heights[id] = nil
  self.widths[id] = nil
end

return M
