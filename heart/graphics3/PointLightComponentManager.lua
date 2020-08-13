local class = require("heart.class")

local M = class.newClass()

function M:init(engine, config)
  self.positions = {}
  self.colors = {}
  self.attenuations = {}
  self.shadowMaps = {}
end

function M:createComponent(entityId, config)
  self.positions[entityId] = config.position or {0, 0, 0}
  self.colors[entityId] = config.color or {1, 1, 1}
  self.attenuations[entityId] = config.attenuation or {0, 0, 4 * math.pi}

  self.shadowMaps[entityId] = love.graphics.newCanvas(256, 256, {
    type = "cube",
    format = "depth32f",
    readable = true,
  })
end

function M:destroyComponent(entityId)
  self.positions[entityId] = nil
  self.colors[entityId] = nil
  self.attenuations[entityId] = nil
  self.shadowMaps[entityId].release()
  self.shadowMaps[entityId] = nil
end

return M
