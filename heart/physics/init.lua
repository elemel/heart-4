local physicsUtils = require("heart.physics.utils")

local M = {}

for k, v in pairs(physicsUtils) do
  M[k] = v
end

return M
