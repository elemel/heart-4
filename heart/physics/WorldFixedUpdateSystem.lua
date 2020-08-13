local class = require("heart.class")

local M = class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.physicsDomain = assert(self.engine.domains.physics)
end

function M:handleEvent(dt)
  self.physicsDomain.world:update(dt)
end

return M
