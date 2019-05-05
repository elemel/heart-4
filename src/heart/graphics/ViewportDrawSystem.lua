local class = require("heart.class")
local mathUtils = require("heart.math.utils")

local ViewportDrawSystem = class.newClass()

function ViewportDrawSystem:init(game, config)
  self.game = assert(game)
  self.bones = assert(self.game.componentManagers.bone)
  self.viewportEntities = assert(self.game.componentEntitySets.viewport)
  self.viewportComponents = assert(self.game.componentManagers.viewport)
end

function ViewportDrawSystem:draw()
  local widths = self.viewportComponents.widths
  local heights = self.viewportComponents.heights

  for entityId in pairs(self.viewportEntities) do
    local viewportTransform = self.bones.transforms[entityId]
    love.graphics.translate(0.5 * widths[entityId], 0.5 * heights[entityId])
    love.graphics.scale(heights[entityId], heights[entityId])

    local _, _, _, scaleX, scaleY = mathUtils.decompose2(viewportTransform)
    local scale = math.sqrt(math.abs(scaleX * scaleY))

    love.graphics.push()
    love.graphics.applyTransform(viewportTransform:inverse())
    love.graphics.setLineWidth(scale / heights[entityId])
    self.game:handleEvent("drawWorld", entityId)
    love.graphics.pop()
  end
end

return ViewportDrawSystem
