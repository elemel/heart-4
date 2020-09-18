local heart = require("heart")

local M = heart.class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.rayIntersections = {}
  self.jointAnchors = {}
end

function M:createComponent(id, config)
  self.rayIntersections[id] = {}

  self.jointAnchors[id] = {
    localPosition = {0, 0},
    localNormal = {0, 0},
  }
end

function M:destroyComponent(id)
  self.jointAnchors[id] = nil
  self.rayIntersections[id] = nil
end

return M
