local class = require("heart.class")

local MeshComponentManager = class.newClass()

function MeshComponentManager:init(game, config)
  self.game = assert(game)
  self.meshResources = assert(game.resourceLoaders.mesh)

  self.meshes = {}

  self.transforms = {}
  self.previousTransforms = {}
  self.interpolatedTransforms = {}
end

function MeshComponentManager:createComponent(id, config, transform)
  if config.mesh then
    self.meshes[id] = self.meshResources:loadResource(config.mesh)
  else
    local vertexCount = assert(config.vertexCount)
    local drawMode = config.drawMode or "fan"
    local usage = config.usage or "dynamic"
    self.meshes[id] = love.graphics.newMesh(vertexCount, drawMode, usage)
  end

  self.transforms[id] = transform:clone()
  self.previousTransforms[id] = transform:clone()
  self.interpolatedTransforms[id] = transform:clone()
end

function MeshComponentManager:destroyComponent(id)
  self.meshes[id] = nil

  self.transforms[id] = nil
  self.previousTransforms[id] = nil
  self.interpolatedTransforms[id] = nil
end

return MeshComponentManager
