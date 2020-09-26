local heart = require("heart")

local M = heart.class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.moveInputs = {}
  self.jumpInputs = {}
  self.previousJumpInputs = {}
end

function M:createComponent(id, config)
  self.moveInputs[id] = {0, 0}
  self.jumpInputs[id] = false
  self.previousJumpInputs[id] = false
end

function M:destroyComponent(id)
  self.previousJumpInputs[id] = nil
  self.jumpInputs[id] = nil
  self.moveInputs[id] = nil
end

return M
