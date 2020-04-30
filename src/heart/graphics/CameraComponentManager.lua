local class = require("heart.class")

local M = class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.transformComponents = assert(self.game.componentManagers.transform)
  self.transforms = {}
end

function M:createComponent(id, config)
  local transform = self.transformComponents.transforms[id]
  self.transforms[id] = transform:clone()
end

function M:destroyComponent(id)
  self.transforms[id] = nil
end

return M
