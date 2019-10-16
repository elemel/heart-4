local BoxComponentManager = heart.class.newClass()

function BoxComponentManager:init(game, config)
  self.widths = {}
  self.heights = {}
end

function BoxComponentManager:createComponent(id, config)
  self.widths[id] = config.width or 1
  self.heights[id] = config.height or 1
end

function BoxComponentManager:destroyComponent(id)
  self.heights[id] = nil
  self.widths[id] = nil
end

return BoxComponentManager
