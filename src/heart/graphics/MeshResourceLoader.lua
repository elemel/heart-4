local class = require("heart.class")
local svg = require("heart.svg")
local xml = require("heart.external.xml")

local MeshResourceLoader = class.newClass()

function MeshResourceLoader:init()
  self.vertexFormat = {
    {"VertexPosition", "float", 2},
    {"VertexTexCoord", "float", 2},
    {"VertexColor", "byte", 4},
    {"BoneIndex", "float", 4},
  }

  self.meshes = {}
end

function MeshResourceLoader:loadResource(filename)
  local mesh = self.meshes[filename]

  if not mesh then
    local text = assert(love.filesystem.read(filename))
    local doc = xml.collect(text)
    local element = svg.findElement(doc, "id", "head")
    local vertices = {}
    self:loadElement(element, vertices)
    mesh = love.graphics.newMesh(self.vertexFormat, vertices, "triangles")
    self.meshes[filename] = mesh
  end

  return mesh
end

function MeshResourceLoader:loadElement(t, vertices)
  if t.label == "path" then
    local pathString = assert(t.xarg.d)
    local path = svg.parsePath(pathString)

    if #path >= 6 then
      local triangles = love.math.triangulate(path)
      local styleString = assert(t.xarg.style)
      local style = svg.parseStyle(styleString)
      local colorString = assert(style.fill)
      local r, g, b = svg.parseColor(colorString)
      local a = 1

      for i, triangle in ipairs(triangles) do
        local x1, y1, x2, y2, x3, y3 = unpack(triangle)
        table.insert(vertices, {x1, y1, 0, 0, r, g, b, a, 0})
        table.insert(vertices, {x2, y2, 0, 0, r, g, b, a, 0})
        table.insert(vertices, {x3, y3, 0, 0, r, g, b, a, 0})
      end
    end
  else
    for i, v in ipairs(t) do
      if type(v) == "table" then
        self:loadElement(v, vertices)
      end
    end
  end
end

return MeshResourceLoader
