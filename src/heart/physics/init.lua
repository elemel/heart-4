local physicsUtils = require("heart.physics.utils")

local physics = {}

for k, v in pairs(physicsUtils) do
  physics[k] = v
end

return physics
