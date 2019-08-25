local class = require("heart.class")

local ParentComponentManager = class.newClass()

function ParentComponentManager:init(game, config)
  self.game = assert(game)
  self.parentingDomain = assert(self.game.domains.parenting)
end

function ParentComponentManager:createComponent(id, config, transform)
  self.parentingDomain.childSets[id] = {}
end

function ParentComponentManager:destroyComponent(id)
  self.parentingDomain.childSets[id] = nil
end

return ParentComponentManager
