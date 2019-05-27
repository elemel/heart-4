local class = require("heart.class")

local Mesh3ComponentManager = class.newClass()

function Mesh3ComponentManager:init(game, config)
  self.game = assert(game)
  self.meshes = {}

  self.vertexFormat = {
    {"VertexPosition", "float", 3},
    {"VertexNormal", "float", 3},
    {"VertexTexCoord", "float", 2},
    {"VertexColor", "float", 4},
  }
end

function Mesh3ComponentManager:createComponent(entityId, config, transform)
  local vertices = {
    -- left

    {-0.5, -0.5, -0.5, -1, 0, 0, 0, 0, 1, 0, 1, 1},
    {-0.5, 0.5, -0.5, -1, 0, 0, 0, 0, 1, 0, 1, 1},
    {-0.5, 0.5, 0.5, -1, 0, 0, 0, 0, 1, 0, 1, 1},

    {-0.5, -0.5, -0.5, -1, 0, 0, 0, 0, 0, 1, 0, 1},
    {-0.5, 0.5, 0.5, -1, 0, 0, 0, 0, 0, 1, 0, 1},
    {-0.5, -0.5, 0.5, -1, 0, 0, 0, 0, 0, 1, 0, 1},

    -- right

    {0.5, -0.5, -0.5, 1, 0, 0, 0, 0, 1, 0, 1, 1},
    {0.5, 0.5, -0.5, 1, 0, 0, 0, 0, 1, 0, 1, 1},
    {0.5, 0.5, 0.5, 1, 0, 0, 0, 0, 1, 0, 1, 1},

    {0.5, -0.5, -0.5, 1, 0, 0, 0, 0, 0, 1, 0, 1},
    {0.5, 0.5, 0.5, 1, 0, 0, 0, 0, 0, 1, 0, 1},
    {0.5, -0.5, 0.5, 1, 0, 0, 0, 0, 0, 1, 0, 1},

    -- top

    {-0.5, -0.5, -0.5, 0, -1, 0, 0, 0, 0, 1, 1, 1},
    {0.5, -0.5, -0.5, 0, -1, 0, 0, 0, 0, 1, 1, 1},
    {0.5, -0.5, 0.5, 0, -1, 0, 0, 0, 0, 1, 1, 1},

    {-0.5, -0.5, -0.5, 0, -1, 0, 0, 0, 0, 0, 1, 1},
    {0.5, -0.5, 0.5, 0, -1, 0, 0, 0, 0, 0, 1, 1},
    {-0.5, -0.5, 0.5, 0, -1, 0, 0, 0, 0, 0, 1, 1},

    -- bottom

    {-0.5, 0.5, -0.5, 0, 1, 0, 0, 0, 0, 1, 1, 1},
    {0.5, 0.5, -0.5, 0, 1, 0, 0, 0, 0, 1, 1, 1},
    {0.5, 0.5, 0.5, 0, 1, 0, 0, 0, 0, 1, 1, 1},

    {-0.5, 0.5, -0.5, 0, 1, 0, 0, 0, 0, 0, 1, 1},
    {0.5, 0.5, 0.5, 0, 1, 0, 0, 0, 0, 0, 1, 1},
    {-0.5, 0.5, 0.5, 0, 1, 0, 0, 0, 0, 0, 1, 1},

    -- back

    {-0.5, -0.5, -0.5, 0, 0, -1, 0, 0, 1, 0, 0, 1},
    {0.5, -0.5, -0.5, 0, 0, -1, 0, 0, 1, 0, 0, 1},
    {0.5, 0.5, -0.5, 0, 0, -1, 0, 0, 1, 0, 0, 1},

    {-0.5, -0.5, -0.5, 0, 0, -1, 0, 0, 1, 1, 0, 1},
    {0.5, 0.5, -0.5, 0, 0, -1, 0, 0, 1, 1, 0, 1},
    {-0.5, 0.5, -0.5, 0, 0, -1, 0, 0, 1, 1, 0, 1},

    -- front

    {-0.5, -0.5, 0.5, 0, 0, 1, 0, 0, 1, 0, 0, 1},
    {0.5, -0.5, 0.5, 0, 0, 1, 0, 0, 1, 0, 0, 1},
    {0.5, 0.5, 0.5, 0, 0, 1, 0, 0, 1, 0, 0, 1},

    {-0.5, -0.5, 0.5, 0, 0, 1, 0, 0, 1, 1, 0, 1},
    {0.5, 0.5, 0.5, 0, 0, 1, 0, 0, 1, 1, 0, 1},
    {-0.5, 0.5, 0.5, 0, 0, 1, 0, 0, 1, 1, 0, 1},
  }

  local mesh = love.graphics.newMesh(self.vertexFormat, vertices, "triangles")
  self.meshes[entityId] = mesh
end

function Mesh3ComponentManager:destroyComponent(entityId)
  self.meshes[entityId] = nil
end

return Mesh3ComponentManager