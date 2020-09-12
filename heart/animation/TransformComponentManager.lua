local class = require("heart.class")
local quaternion = require("heart.quaternion")
local heartMath = require("heart.math")
local UniformTransform = require("heart.UniformTransform")

local atan2 = math.atan2
local cos = math.cos
local fromAxisAngle = quaternion.fromAxisAngle
local mix4 = heartMath.mix4
local normalize = quaternion.normalize
local sin = math.sin
local sqrt = math.sqrt

local M = class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)

  self.localTransforms = {}
  self.transforms = {}
  self.previousTransforms = {}

  self.modes = {}

  self.dirtySet = {}
  self.previousDirtySet = {}
end

function M:createComponent(id, config)
  local x = 0
  local y = 0
  local z = 0
  local w = 1

  local qx = 0
  local qy = 0
  local qz = 0
  local qw = 1

  if config.transform then
    x = config.transform[1] or 0
    y = config.transform[2] or 0
    z = 0
    w = config.transform[4] or 1

    angle = config.transform[3] or 0
    qx, qy, qz, qw = fromAxisAngle(0, 0, 1, angle)
  end

  self.localTransforms[id] = UniformTransform.new(x, y, z, w, qx, qy, qz, qw)
  self.transforms[id] = UniformTransform.new(x, y, z, w, qx, qy, qz, qw)
  self.previousTransforms[id] = UniformTransform.new(x, y, z, w, qx, qy, qz, qw)

  local parentId = self.engine.entityParents[id]

  if parentId then
    self:getTransform(parentId):multiply(self.localTransforms[id], self.transforms[id])
    self.previousTransforms[id]:set(self.transforms[id]:get())
  end

  self.modes[id] = config.mode or "local"
end

function M:destroyComponent(id)
  self.previousDirtySet[id] = nil
  self.dirtySet[id] = nil

  self.modes[id] = nil

  self.previousTransforms[id] = nil
  self.transforms[id] = nil
  self.localTransforms[id] = nil
end

function M:getLocalTransform(id)
  if self.modes[id] == "world" and self.dirtySet[id] then
    self:setDirty(id, false)
  end

  return self.localTransforms[id]
end

function M:getTransform(id)
  if self.modes[id] == "local" and self.dirtySet[id] then
    self:setDirty(id, false)
  end

  return self.transforms[id]
end

function M:setMode(id, mode)
  assert(mode == "local" or mode == "world", "Invalid mode")

  if mode ~= self.modes[id] then
    self:setDirty(id, false)
    self.modes[id] = mode
  end
end

function M:setDirty(id, dirty)
  if dirty then
    if not self.dirtySet[id] then
      self.dirtySet[id] = true
      self.previousDirtySet[id] = true

      local children = self.engine.entityChildSets[id]

      if children then
        for childId in pairs(children) do
          self:setDirty(childId, true)
        end
      end
    end
  else
    if self.dirtySet[id] then
      local parentId = self.engine.entityParents[id]

      if parentId then
        self:setDirty(parentId, false)

        if self.modes[id] == "local" then
          self.transforms[parentId]:multiply(
            self.localTransforms[id], self.transforms[id])
        else
          self.localTransforms[id]:set(self.transforms[parentId]:get())
          self.localTransforms[id]:invert()

          self.localTransforms[id]:multiply(
            self.transforms[id], self.localTransforms[id])
        end
      else
        if self.modes[id] == "local" then
          self.transforms[id]:set(self.localTransforms[id]:get())
        else
          self.localTransforms[id]:set(self.transforms[id]:get())
        end
      end

      self.dirtySet[id] = nil
    end
  end
end

function M:getInterpolatedTransform(id, t, result)
  result = result or UniformTransform.new()

  if self.previousDirtySet[id] then
    if self.modes[id] == "local" and self.dirtySet[id] then
      self:setDirty(id, false)
    end

    UniformTransform.mix(
      self.previousTransforms[id],
      self.transforms[id],
      t,
      result)
  else
    result:set(self.transforms[id]:get())
  end

  return result
end

function M:updateTransforms()
  for id in pairs(self.dirtySet) do
    self:setDirty(id, false)
  end
end

function M:updatePreviousTransforms()
  self:updateTransforms()

  for id in pairs(self.previousDirtySet) do
    self.previousTransforms[id]:set(self.transforms[id]:get())
    self.previousDirtySet[id] = nil
  end
end

return M
