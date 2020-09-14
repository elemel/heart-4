local heart = require("heart")

local M = heart.class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.bounds = config.bounds or {{-1, -1}, {1, 1}}
end

return M
