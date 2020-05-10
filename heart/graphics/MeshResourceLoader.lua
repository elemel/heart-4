local class = require("heart.class")
local svg = require("heart.svg")
local xml = require("heart.xml")

local M = class.newClass()

function M:init()
  self.meshes = {}
end

function M:loadResource(filename)
  local mesh = self.meshes[filename]

  if not mesh then
    local text = assert(love.filesystem.read(filename))
    local document = xml.parseDocument(text)
    local element = document[#document]
    local vertices = {}
    self:loadElement(element, vertices)
    mesh = love.graphics.newMesh(vertices, "triangles")
    self.meshes[filename] = mesh
  end

  return mesh
end

function M:loadElement(element, vertices)
  if element.name == "path" then
    local pathString = assert(element.attributes.d)
    local path = svg.parsePath(pathString)
    local polygon = svg.renderPath(path)

    if #polygon >= 6 then
      local triangles = love.math.triangulate(polygon)
      local styleString = assert(element.attributes.style)
      local style = svg.parseStyle(styleString)
      local colorString = assert(style.fill)
      local r, g, b = svg.parseColor(colorString)
      local a = 1

      for i, triangle in ipairs(triangles) do
        local x1, y1, x2, y2, x3, y3 = unpack(triangle)
        table.insert(vertices, {x1, y1, 0, 0, r, g, b, a})
        table.insert(vertices, {x2, y2, 0, 0, r, g, b, a})
        table.insert(vertices, {x3, y3, 0, 0, r, g, b, a})
      end
    end
  else
    for i, v in ipairs(element) do
      if type(v) == "table" then
        self:loadElement(v, vertices)
      end
    end
  end
end

return M
