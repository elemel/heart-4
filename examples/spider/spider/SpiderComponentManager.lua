local heart = require("heart")

local M = heart.class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.moveInputs = {}
  self.jumpInputs = {}
end

function M:createComponent(id, config)
  self.moveInputs[id] = {0, 0}
  self.jumpInputs[id] = false
end

function M:destroyComponent(id)
  self.jumpInputs[id] = nil
  self.moveInputs[id] = nil
end

return M
