local class = require("heart.class")
local quaternion = require("heart.quaternion")

local atan2 = math.atan2
local cos = math.cos
local invert = quaternion.invert
local normalize = quaternion.normalize
local product = quaternion.product
local rotate = quaternion.rotate
local sin = math.sin
local toMatrix = quaternion.toMatrix

local M = class.newClass()

function M:init(x, y, z, w, qx, qy, qz, qw)
  -- Position
  self.x = x or 0
  self.y = y or 0
  self.z = z or 0

  -- Scale
  self.w = w or 1

  -- Orientation
  self.qx = qx or 0
  self.qy = qy or 0
  self.qz = qz or 0
  self.qw = qw or 1
end

function M:transformPoint(x, y, z)
  z = z or 0

  x, y, z = rotate(
    self.qx, self.qy, self.qz, self.qw,
    x, y, z)

  return x * self.w + self.x, y * self.w + self.y, z * self.w + self.z
end

function M:inverseTransformPoint(x, y, z)
  z = z or 0

  x = (x - self.x) / self.w
  y = (y - self.y) / self.w
  z = (z - self.z) / self.w

  return rotate(self.qx, self.qy, self.qz, -self.qw, x, y, z)
end

function M:transformVector(x, y, z)
  z = z or 0

  return rotate(
    self.qx, self.qy, self.qz, self.qw,
    x * self.w, y * self.w, z * self.w)
end

function M:inverseTransformVector(x, y, z)
  z = z or 0

  return rotate(
    self.qx, self.qy, self.qz, -self.qw,
    x / self.w, y / self.w, z / self.w)
end

function M:get()
  return self.x, self.y, self.z, self.w, self.qx, self.qy, self.qz, self.qw
end

function M:set(x, y, z, w, qx, qy, qz, qw)
  self.x = x
  self.y = y
  self.z = z
  self.w = w

  self.qx = qx
  self.qy = qy
  self.qz = qz
  self.qw = qw
end

function M:getPosition()
  return self.x, self.y, self.z
end

function M:setPosition(x, y, z)
  self.x = x
  self.y = y
  self.z = z
end

function M:getScale()
  return self.w
end

function M:setScale(w)
  self.w = w
end

function M:getOrientation()
  return self.qx, self.qy, self.qz, self.qw
end

function M:setOrientation(qx, qy, qz, qw)
  self.qx = qx
  self.qy = qy
  self.qz = qz
  self.qw = qw
end

function M:getTransform2()
  -- See: https://stackoverflow.com/questions/5782658/extracting-yaw-from-a-quaternion
  local angle = 2 * atan2(self.qz, self.qw)

  return self.x, self.y, angle, self.w
end

function M:setTransform2(x, y, angle, scale)
  x = x or 0
  y = y or 0

  angle = angle or 0
  scale = scale or 1

  local qz = sin(0.5 * angle)
  local qw = cos(0.5 * angle)

  self:set(x, y, 0, scale, 0, 0, qz, qw)
end

function M:getMatrix()
  local x, y, z, w, qx, qy, qz, qw = self:get()
  local mxx, mxy, mzz, myx, myy, myz, mzx, mzy, mzz = toMatrix(qx, qy, qz, qw)

  return w * mxx, w * mxy, w * mzz, x,
    w * myx, w * myy, w * myz, y,
    w * mzx, w * mzy, w * mzz, z,
    0, 0, 0, 1
end

function M:invert()
  local qx, qy, qz, qw = invert(self.qx, self.qy, self.qz, self.qw)
  local w = 1 / self.w

  local x, y, z = rotate(
    qx, qy, qz, qw,
    -self.x * w, -self.y * w, -self.z * w)

  self:set(x, y, z, w, qx, qy, qz, qw)
end

function M:normalize()
  self.qx, self.qy, self.qz, self.qw = normalize(
    self.qx, self.qy, self.qz, self.qw)
end

function M.multiply(left, right, result)
  result = result or M.new()

  local x, y, z = rotate(
    left.qx, left.qy, left.qz, left.qw,
    right.x, right.y, right.z)

  x = left.w * x + left.x
  y = left.w * y + left.y
  z = left.w * z + left.z

  local w = left.w * right.w

  local qx, qy, qz, qw = product(
    left.qx, left.qy, left.qz, left.qw,
    right.qx, right.qy, right.qz, right.qw)

  result:set(x, y, z, w, qx, qy, qz, qw)
  return result
end

-- TODO: Slerp?
function M.mix(left, right, t, result)
  result = result or M.new()

  result.x = (1 - t) * left.x + t * right.x
  result.y = (1 - t) * left.y + t * right.y
  result.z = (1 - t) * left.z + t * right.z
  result.w = (1 - t) * left.w + t * right.w

  result.qx = (1 - t) * left.qx + t * right.qx
  result.qy = (1 - t) * left.qy + t * right.qy
  result.qz = (1 - t) * left.qz + t * right.qz
  result.qw = (1 - t) * left.qw + t * right.qw

  return result
end

return M
