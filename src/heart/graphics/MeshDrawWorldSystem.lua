local class = require("heart.class")
local heartTable = require("heart.table")

local MeshDrawWorldSystem = class.newClass()

function MeshDrawWorldSystem:init(game, config)
  self.game = assert(game)
  self.meshComponents = assert(self.game.componentManagers.mesh)
end

function MeshDrawWorldSystem:drawWorld(viewportId)
  local transforms = self.meshComponents.interpolatedTransforms

  for id, mesh in pairs(self.meshComponents.meshes) do
    love.graphics.draw(mesh, transforms[id])
  end
end

return MeshDrawWorldSystem
