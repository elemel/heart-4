local class = require("heart.class")
local heartTable = require("heart.table")

local set2 = heartTable.set2

local ParentingDomain = class.newClass()

function ParentingDomain:init(game, config)
  self.game = assert(game)
  self.parents = {}
  self.childSets = {}
end

function ParentingDomain:setParent(childId, parentId)
  local oldParentId = self.parents[childId]

  if parentId ~= oldParentId then
    if oldParentId then
      set2(self.childSets[oldParentId], childId, nil)
    end

    self.parents[childId] = parentId

    if parentId then
      set2(self.childSets[parentId], childId, true)
    end
  end
end

return ParentingDomain
