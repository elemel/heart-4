local M = heart.class.newClass()

function M:init(engine, config)
  self.meshes = {}
end

function M:createComponent(id, config)
  local r1, g1, b1, a1, r2, g2, b2, a2 = unpack(config.colors)

  local mesh = love.graphics.newMesh({
    {0, 0, 0, 0, r1, g1, b1, a1},
    {1, 0, 0, 0, r1, g1, b1, a1},
    {1, 1, 0, 0, r2, g2, b2, a2},
    {0, 1, 0, 0, r2, g2, b2, a2},
  })

  self.meshes[id] = mesh
end

function M:destroyComponent(id)
  self.meshes[id]:release()
  self.meshes[id] = nil
end

return M
