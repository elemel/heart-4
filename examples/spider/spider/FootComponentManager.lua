local heart = require("heart")

local M = heart.class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.localJointNormals = {}
end

function M:createComponent(id, config)
  self.localJointNormals[id] = {}
end

function M:destroyComponent(id)
  self.localJointNormals[id] = nil
end

return M
