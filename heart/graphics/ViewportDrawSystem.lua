local class = require("heart.class")
local heartMath = require("heart.math")

local M = class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)

  self.cameraEntities = assert(self.engine.componentEntitySets.camera)
  self.viewportEntities = assert(self.engine.componentEntitySets.viewport)

  self.cameraComponents = assert(self.engine.componentManagers.camera)
  self.transformComponents = assert(self.engine.componentManagers.transform)
  self.viewportComponents = assert(self.engine.componentManagers.viewport)
end

function M:handleEvent()
  local sizes = self.viewportComponents.sizes
  local transforms = self.cameraComponents.transforms
  local debugTransforms = self.transformComponents.transforms

  for id in pairs(self.viewportEntities) do
    if self.cameraEntities[id] then
      local width, height = unpack(sizes[id])
      local transform = transforms[id]
      local _, _, _, scaleX, scaleY = heartMath.decompose2(transform)
      local scale = math.sqrt(math.abs(scaleX * scaleY))

      love.graphics.push()
      love.graphics.translate(0.5 * width, 0.5 * height)
      love.graphics.scale(height, height)
      love.graphics.applyTransform(transform:inverse())
      love.graphics.setLineWidth(scale / height)
      self.engine:handleEvent("drawworld", id)
      love.graphics.pop()

      local debugTransform = debugTransforms[id]

      local _, _, _, debugScaleX, debugScaleY =
        heartMath.decompose2(debugTransform)

      local debugScale = math.sqrt(math.abs(debugScaleX * debugScaleY))

      love.graphics.push()
      love.graphics.translate(0.5 * width, 0.5 * height)
      love.graphics.scale(height, height)
      love.graphics.applyTransform(love.math.newTransform():setMatrix(debugTransform:getMatrix()):inverse())
      love.graphics.setLineWidth(scale / height)
      love.graphics.setColor(0, 1, 0, 1)
      self.engine:handleEvent("debugdraw", id)
      love.graphics.setColor(1, 1, 1, 1)
      love.graphics.pop()
    end
  end
end

return M
