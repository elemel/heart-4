local mathUtils = require("heart.math.utils")

local heartMath = {}

for k, v in pairs(mathUtils) do
  heartMath[k] = v
end

return heartMath
