local cos = math.cos
local sin = math.sin
local sqrt = math.sqrt
local sub = string.sub

-- https://en.wikipedia.org/wiki/Quaternions_and_spatial_rotation#The_conjugation_operation
local function conjugate(x, y, z, w)
  return -x, -y, -z, w
end

local function invert(x, y, z, w)
  local a = 1 / (x * x + y * y + z * z + w * w)
  return a * -x, a * -y, a * -z, a * w
end

-- https://www.euclideanspace.com/maths/geometry/rotations/conversions/angleToQuaternion/index.htm
local function fromAxisAngle(ax, ay, az, angle)
  local qx = ax * sin(0.5 * angle)
  local qy = ay * sin(0.5 * angle)
  local qz = az * sin(0.5 * angle)

  local qw = cos(0.5 * angle)
  return qx, qy, qz, qw
end

local function normalize(x, y, z, w)
  local length = sqrt(x * x + y * y + z * z + w * w)
  local a = (w < 0 and -1 or 1) / length
  return a * x, a * y, a * z, a * w, length
end

local axisVectors = {
  x = {1, 0, 0},
  y = {0, 1, 0},
  z = {0, 0, 1},
}

local function fromEulerAngles(axes, ...)
  local qx = 0
  local qy = 0
  local qz = 0
  local qw = 1

  for i = 1, #axes do
    local axis = sub(axes, i, i)
    local axisVector = assert(axisVectors[axis], "Invalid axis")
    local ax, ay, az = unpack(axisVector)
    local angle = select(i, ...)

    qx, qy, qz, qw = product(
      qx, qy, qz, qw, fromAxisAngle(ax, ay, az, angle))
  end

  return qx, qy, qz, qw
end

-- https://en.wikipedia.org/wiki/Quaternion#Hamilton_product
local function product(qx1, qy1, qz1, qw1, qx2, qy2, qz2, qw2)
  local qx = qw1 * qx2 + qx1 * qw2 + qy1 * qz2 - qz1 * qy2
  local qy = qw1 * qy2 - qx1 * qz2 + qy1 * qw2 + qz1 * qx2
  local qz = qw1 * qz2 + qx1 * qy2 - qy1 * qx2 + qz1 * qw2
  local qw = qw1 * qw2 - qx1 * qx2 - qy1 * qy2 - qz1 * qz2

  return qx, qy, qz, qw
end

-- https://en.wikipedia.org/wiki/Quaternions_and_spatial_rotation#Using_quaternion_as_rotations
local function rotate(qx, qy, qz, qw, x, y, z)
  local qx2, qy2, qz2, qw2 = product(qx, qy, qz, qw, x, y, z, 0)
  local x2, y2, z2 = product(qx2, qy2, qz2, qw2, -qx, -qy, -qz, qw)
  return x2, y2, z2
end

-- https://www.euclideanspace.com/maths/geometry/rotations/conversions/quaternionToMatrix/index.htm
local function toMatrix(qx, qy, qz, qw)
  local mxx = 1 - 2 * qy * qy - 2 * qz * qz
  local mxy =  2 * qx * qy - 2 * qz * qw
  local mxz = 2 * qx * qz + 2 * qy * qw

  local myx = 2 * qx * qy + 2 * qz * qw
  local myy = 1 - 2 * qx * qx - 2 * qz * qz
  local myz = 2 * qy * qz - 2 * qx * qw

  local mzx = 2 * qx * qz - 2 * qy * qw
  local mzy = 2 * qy * qz + 2 * qx * qw
  local mzz = 1 - 2 * qx * qx - 2 * qy * qy

  return mxx, mxy, mxz, myx, myy, myz, mzx, mzy, mzz
end

return {
  conjugate = conjugate,
  fromAxisAngle = fromAxisAngle,
  invert = invert,
  product = product,
  normalize = normalize,
  rotate = rotate,
  toMatrix = toMatrix,
}
