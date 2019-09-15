local SkyComponentManager = heart.class.newClass()

function SkyComponentManager:init(game, config)
  self.meshes = {}
end

function SkyComponentManager:createComponent(id, config, transform)
  local r1, g1, b1, a1, r2, g2, b2, a2 = unpack(config.colors)

  local mesh = love.graphics.newMesh({
    {0, 0, 0, 0, r1, g1, b1, a1},
    {1, 0, 0, 0, r1, g1, b1, a1},
    {1, 1, 0, 0, r2, g2, b2, b2},
    {0, 1, 0, 0, r2, g2, b2, b2},
  })

  self.meshes[id] = mesh
end

function SkyComponentManager:destroyComponent(id)
  self.meshes[id]:release()
  self.meshes[id] = nil
end

return SkyComponentManager
