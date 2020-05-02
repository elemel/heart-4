local class = require("heart.class")

local M = class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.meshResources = assert(game.resourceLoaders.mesh)
  self.transformManager = assert(self.game.componentManagers.transform)

  self.meshes = {}
  self.transforms = {}
end

function M:createComponent(id, config)
  local transform = self.transformManager.transforms[id]

  if config.mesh then
    self.meshes[id] = self.meshResources:loadResource(config.mesh)
  else
    local vertexCount = assert(config.vertexCount)
    local drawMode = config.drawMode or "fan"
    local usage = config.usage or "dynamic"
    self.meshes[id] = love.graphics.newMesh(vertexCount, drawMode, usage)
  end

  self.transforms[id] = transform:clone()
end

function M:destroyComponent(id)
  self.meshes[id] = nil
  self.transforms[id] = nil
end

return M