local class = require("heart.class")
local heartMath = require("heart.math")

local ViewportDrawSystem = class.newClass()

function ViewportDrawSystem:init(game, config)
  self.game = assert(game)
  self.viewportEntities = assert(self.game.componentEntitySets.viewport)
  self.cameraEntities = assert(self.game.componentEntitySets.camera)
  self.viewportComponents = assert(self.game.componentManagers.viewport)
  self.cameraComponents = assert(self.game.componentManagers.camera)
  self.transformComponents = assert(self.game.componentManagers.transform)
end

function ViewportDrawSystem:draw()
  local widths = self.viewportComponents.widths
  local heights = self.viewportComponents.heights
  local transforms = self.cameraComponents.transforms
  local debugTransforms = self.transformComponents.transforms

  for id in pairs(self.viewportEntities) do
    if self.cameraEntities[id] then
      local transform = transforms[id]
      local _, _, _, scaleX, scaleY = heartMath.decompose2(transform)
      local scale = math.sqrt(math.abs(scaleX * scaleY))

      love.graphics.push()
      love.graphics.translate(0.5 * widths[id], 0.5 * heights[id])
      love.graphics.scale(heights[id], heights[id])
      love.graphics.applyTransform(transform:inverse())
      love.graphics.setLineWidth(scale / heights[id])
      self.game:handleEvent("drawWorld", id)
      love.graphics.pop()

      local debugTransform = debugTransforms[id]

      local _, _, _, debugScaleX, debugScaleY =
        heartMath.decompose2(debugTransform)

      local debugScale = math.sqrt(math.abs(debugScaleX * debugScaleY))

      love.graphics.push()
      love.graphics.translate(0.5 * widths[id], 0.5 * heights[id])
      love.graphics.scale(heights[id], heights[id])
      love.graphics.applyTransform(debugTransform:inverse())
      love.graphics.setLineWidth(scale / heights[id])
      love.graphics.setColor(0, 1, 0, 1)
      self.game:handleEvent("debugDraw", id)
      love.graphics.setColor(1, 1, 1, 1)
      love.graphics.pop()
    end
  end
end

return ViewportDrawSystem
