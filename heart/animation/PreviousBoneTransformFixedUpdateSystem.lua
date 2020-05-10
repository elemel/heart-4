local class = require("heart.class")

local M = class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.boneEntities = assert(self.game.componentEntitySets.bone)
  self.boneComponents = assert(self.game.componentManagers.bone)
  self.transformComponents = assert(self.game.componentManagers.transform)
end

function M:__call(dt)
  local previousTransforms = self.boneComponents.previousTransforms
  local transforms = self.transformComponents.transforms

  for id in pairs(self.boneEntities) do
    previousTransforms[id]:reset():apply(transforms[id])
  end
end

return M
