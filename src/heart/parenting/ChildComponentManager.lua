local class = require("heart.class")

local ChildComponentManager = class.newClass()

function ChildComponentManager:init(game, config)
  self.game = assert(game)
  self.parentingDomain = assert(self.game.domains.parenting)
end

function ChildComponentManager:createComponent(id, config, transform)
  self.parentingDomain:setParent(id, config.parent)
end

function ChildComponentManager:destroyComponent(id)
  self.parentingDomain:setParent(id, nil)
end

return ChildComponentManager
