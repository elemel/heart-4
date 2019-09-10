local GravityComponentManager = heart.class.newClass()

function GravityComponentManager:init(game, config)
  self.game = assert(game)

  self.defaultGravityX = config.defaultGravityX or 0
  self.defaultGravityY = config.defaultGravityY or 0

  self.gravityXs = {}
  self.gravityYs = {}
end

function GravityComponentManager:createComponent(id, config, transform)
  self.gravityXs[id] = config.gravityX or self.defaultGravityX
  self.gravityYs[id] = config.gravityY or self.defaultGravityY
end

function GravityComponentManager:destroyComponent(id)
  self.gravityXs[id] = nil
  self.gravityYs[id] = nil
end

return GravityComponentManager
