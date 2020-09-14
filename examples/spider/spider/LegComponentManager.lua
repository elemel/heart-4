local heart = require("heart")

local M = heart.class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.ranges = {}
  self.targets = {}
end

function M:createComponent(id, config)
  self.ranges[id] = config.range or 1

  self.targets[id] = {
    nil, -- Fixture
    0, 0, -- Position
    0, 0, -- Normal
  }
end

function M:destroyComponent(id)
  self.targets[id] = nil
  self.ranges[id] = nil
end

return M
