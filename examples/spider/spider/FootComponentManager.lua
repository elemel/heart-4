local heart = require("heart")

local M = heart.class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.transformComponents = assert(engine.componentManagers.transform)

  self.restLocalPositions = {}
  self.restKneeDirections = {}

  self.kneeDirections = {}
  self.localJointNormals = {}
end

function M:createComponent(id, config)
  self.restLocalPositions[id] = {self.transformComponents:getLocalTransform(id):getPosition()}

  local parentId = self.engine.entityParents[id]
  local parentLocalX, parentLocalY = self.transformComponents:getLocalTransform(parentId):getPosition()
  self.restKneeDirections[id] = parentLocalX * parentLocalY < 0 and -1 or 1

  self.kneeDirections[id] = self.restKneeDirections[id]
  self.localJointNormals[id] = {}
end

function M:destroyComponent(id)
  self.localJointNormals[id] = nil
  self.kneeDirections[id] = nil

  self.restKneeDirections[id] = nil
  self.restLocalPositions[id] = nil
end

return M
