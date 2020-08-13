local heart = require("heart")

local M = heart.class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.physicsDomain = assert(self.engine.domains.physics)
  self.transformComponents = assert(self.engine.componentManagers.transform)
  self.localRays = {}
  self.filters = {}
  self.contacts = {}
end

function M:createComponent(id, config)
  local transform = self.transformComponents.transforms[id]
  local body = self.physicsDomain.bodies[id]
  local ray = config.ray or {0, 0, 0, 1}
  local x1, y1, x2, y2 = unpack(ray)

  x1, y1 = body:getLocalPoint(transform:transformPoint(x1, y1))
  x2, y2 = body:getLocalPoint(transform:transformPoint(x2, y2))

  self.localRays[id] = {x1, y1, x2, y2}
end

function M:destroyComponent(id)
  self.localRays[id] = nil
  self.filters[id] = nil
  self.contacts[id] = nil
end

return M
