local heart = require("heart")

local M = heart.class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.moveInputs = {}
end

function M:createComponent(id, config)
  self.moveInputs[id] = {0, 0}
end

function M:destroyComponent(id)
  self.moveInputs[id] = nil
end

return M
