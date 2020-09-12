local class = require("heart.class")

local M = class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.transformComponents = assert(self.engine.componentManagers.transform)
end

function M:handleEvent(dt)
  self.transformComponents:updatePreviousTransforms()
end

return M
