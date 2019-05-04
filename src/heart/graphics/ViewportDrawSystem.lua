local class = require("heart.class")
local mathUtils = require("heart.math.utils")

local ViewportDrawSystem = class.newClass()

function ViewportDrawSystem:init(game, config)
  self.game = assert(game)
  self.bones = assert(self.game.componentManagers.bone)
  self.viewportEntities = assert(self.game.componentEntitySets.viewport)
end

function ViewportDrawSystem:draw()
  for entityId in pairs(self.viewportEntities) do
    local viewportTransform = self.bones.transforms[entityId]

    local _, _, _, scaleX, scaleY = mathUtils.decompose2(viewportTransform)
    local scale = math.sqrt(math.abs(scaleX * scaleY))

    love.graphics.push()
    love.graphics.applyTransform(viewportTransform:inverse())
    love.graphics.setLineWidth(scale)
    self.game:handleEvent("drawWorld", entityId)
    love.graphics.pop()
  end
end

return ViewportDrawSystem
