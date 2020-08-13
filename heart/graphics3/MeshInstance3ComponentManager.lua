local class = require("heart.class")

local M = class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.meshes = {}

  self.vertexFormat = {
    {"VertexPosition", "float", 3},
    {"VertexNormal", "float", 3},
    {"VertexTexCoord", "float", 2},
    {"VertexColor", "float", 4},
  }
end

function M:createComponent(entityId, config)
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

function M:destroyComponent(entityId)
  self.meshes[entityId] = nil
end

return M
