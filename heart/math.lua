local abs = math.abs
local acos = math.acos
local atan2 = math.atan2
local cos = math.cos
local max = math.max
local min = math.min
local modf = math.modf
local pi = math.pi
local sin = math.sin
local sqrt = math.sqrt

local function sign(x)
  return x < 0 and -1 or 1
end

local function clamp(x, x1, x2)
  return min(max(x, x1), x2)
end

-- https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/smoothstep.xhtml
local function smoothstep(x1, x2, x)
  local t = clamp((x - x1) / (x2 - x1), 0, 1)
  return t * t * (3 - 2 * t)
end

local function length2(x, y)
  return sqrt(x * x + y * y)
end

local function squaredDistance2(x1, y1, x2, y2)
  return (x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1)
end

local function distance2(x1, y1, x2, y2)
  return sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1))
end

local function dot2(x1, y1, x2, y2)
  return x1 * x2 + y1 * y2
end

local function cross2(x1, y1, x2, y2)
  return x1 * y2 - x2 * y1
end

local function normalize2(x, y)
  local length = length2(x, y)

  if length == 0 then
    return 1, 0, 0
  end

  return x / length, y / length, length
end

local function clampLength2(x, y, minLength, maxLength)
  local x, y, length = normalize2(x, y)
  local clampedLength = clamp(length, minLength, maxLength)
  return x * clampedLength, y * clampedLength, length
end

local function mix(x1, x2, t)
  return (1 - t) * x1 + t * x2
end

local function mix2(x1, y1, x2, y2, t)
  return (1 - t) * x1 + t * x2, (1 - t) * y1 + t * y2
end

local function normalizeAngle(a)
  return (a + pi) % (2 * pi) - pi
end

local function mixAngles(a1, a2, t)
  return a1 + normalizeAngle(a2 - a1) * t
end

-- http://frederic-wang.fr/decomposition-of-2d-transform-matrices.html
local function decompose2(transform)
  local t11, t12, t13, t14,
    t21, t22, t23, t24,
    t31, t32, t33, t34,
    t41, t42, t43, t44 = transform:getMatrix()

  local x = t14
  local y = t24
  local angle = 0
  local scaleX = t11 * t11 + t21 * t21
  local scaleY = t12 * t12 + t22 * t22
  local shearX = 0
  local shearY = 0

  if scaleX + scaleY ~= 0 then
    local det = t11 * t22 - t12 * t21

    if scaleX >= scaleY then
      shearX = (t11 * t12 + t21 * t22) / scaleX
      scaleX = sqrt(scaleX)
      angle = sign(t21) * acos(t11 / scaleX)
      scaleY = det / scaleX
    else
      shearY = (t11 * t12 + t21 * t22) / scaleY
      scaleY = sqrt(scaleY)
      angle = 0.5 * pi - sign(t22) * acos(-t12 / scaleY)
      scaleX = det / scaleY
    end
  end

  return x, y, angle, scaleX, scaleY, 0, 0, shearX, shearY
end

local function mixTransforms(a, b, t, c)
  local a11, a12, a13, a14,
    a21, a22, a23, a24,
    a31, a32, a33, a34,
    a41, a42, a43, a44 = a:getMatrix()

  local b11, b12, b13, b14,
    b21, b22, b23, b24,
    b31, b32, b33, b34,
    b41, b42, b43, b44 = b:getMatrix()

  local s = 1 - t

  local c11 = s * a11 + t * b11
  local c12 = s * a12 + t * b12
  local c13 = s * a13 + t * b13
  local c14 = s * a14 + t * b14

  local c21 = s * a21 + t * b21
  local c22 = s * a22 + t * b22
  local c23 = s * a23 + t * b23
  local c24 = s * a24 + t * b24

  local c31 = s * a31 + t * b31
  local c32 = s * a32 + t * b32
  local c33 = s * a33 + t * b33
  local c34 = s * a34 + t * b34

  local c41 = s * a41 + t * b41
  local c42 = s * a42 + t * b42
  local c43 = s * a43 + t * b43
  local c44 = s * a44 + t * b44

  c = c or love.math.newTransform()

  c:setMatrix(
    c11, c12, c13, c14,
    c21, c22, c23, c24,
    c31, c32, c33, c34,
    c41, c42, c43, c44)

  return c, c34
end

local function transformPoints2(transform, source, target)
  target = target or {}
  local transformPoint = transform.transformPoint

  for i = 1, #source, 2 do
    target[#target + 1], target[#target + 2] =
      transformPoint(transform, source[i], source[i + 1])
  end

  return target
end

local function transformVector2(transform, x, y)
  local originX, originY = transform:transformPoint(0, 0)
  local worldX, worldY = transform:transformPoint(x, y)
  return worldX - originX, worldY - originY
end

local function transformAngle(transform, angle)
  local originX, originY = transform:transformPoint(0, 0)
  local worldX, worldY = transform:transformPoint(cos(angle), sin(angle))
  return atan2(worldY - originY, worldX - originX)
end

local function transformRadius(transform, radius)
  local _, _, _, scaleX, scaleY = decompose2(transform)
  local scale = sqrt(abs(scaleX * scaleY))
  return scale * radius
end

local rectangleVerticesTransform = love.math.newTransform()

local function rectangleVertices(x, y, width, height, angle)
  local transform = rectangleVerticesTransform
  transform:setTransformation(x, y, angle, width, height)
  local x1, y1 = transform:transformPoint(-0.5, -0.5)
  local x2, y2 = transform:transformPoint(0.5, -0.5)
  local x3, y3 = transform:transformPoint(0.5, 0.5)
  local x4, y4 = transform:transformPoint(-0.5, 0.5)
  return x1, y1, x2, y2, x3, y3, x4, y4
end

local globalTransform = love.math.newTransform()

local function newTransform3(
  x, y, z, rx, ry, rz, sx, sy, sz, ox, oy, oz, kx, ky, kz)

  local transform = love.math.newTransform()

  if x or y or z then
    globalTransform:setMatrix(
      1, 0, 0, x or 0,
      0, 1, 0, y or 0,
      0, 0, 1, z or 0,
      0, 0, 0, 1)

    transform:apply(globalTransform)
  end

  if rz then
    globalTransform:setMatrix(
      cos(rz), -sin(rz), 0, 0,
      sin(rz), cos(rz), 0, 0,
      0, 0, 1, 0,
      0, 0, 0, 1)

    transform:apply(globalTransform)
  end

  if sx or sy or sz then
    globalTransform:setMatrix(
      sx or 1, 0, 0, 0,
      0, sy or 1, 0, 0,
      0, 0, sz or 1, 0,
      0, 0, 0, 1)

    transform:apply(globalTransform)
  end

  if ox or oy or oz then
    globalTransform:setMatrix(
      1, 0, 0, -(ox or 0),
      0, 1, 0, -(oy or 0),
      0, 0, 1, -(oz or 0),
      0, 0, 0, 1)

    transform:apply(globalTransform)
  end

  return transform
end

local function bounds2(points)
  local minX = math.huge
  local minY = math.huge

  local maxX = -math.huge
  local maxY = -math.huge

  for i = 1, #points, 2 do
    local x = points[i]
    local y = points[i + 1]

    minX = min(minX, x)
    minY = min(minY, y)

    maxX = max(maxX, x)
    maxY = max(maxY, y)
  end

  return minX, minY, maxX, maxY
end

local function rotate2(x, y, angle)
  local cosAngle = cos(angle)
  local sinAngle = sin(angle)

  return cosAngle * x - sinAngle * y, sinAngle * x + cosAngle * y
end

local function fbm(x, noise, octave, lacunarity, gain)
    noise = noise or love.math.noise
    octave = octave or 3
    lacunarity = lacunarity or 2
    gain = gain or 1 / lacunarity

    local integralOctave, fractionalOctave = modf(octave)
    local amplitude = 1

    local totalNoise = 0
    local totalAmplitude = 0

    for i = 1, integralOctave do
        totalNoise = totalNoise + amplitude * noise(x, 0)
        totalAmplitude = totalAmplitude + amplitude

        x = x * lacunarity
        amplitude = amplitude * gain
    end

    if fractionalOctave > 0 then
        totalNoise = totalNoise + fractionalOctave * amplitude * noise(x)
        totalAmplitude = totalAmplitude + fractionalOctave * amplitude
    end

    return totalNoise / totalAmplitude
end

local function fbm2(x, y, noise, octave, lacunarityX, lacunarityY, gain)
    noise = noise or love.math.noise
    octave = octave or 3
    lacunarityX = lacunarityX or 2
    lacunarityY = lacunarityY or 2
    gain = gain or 2 / (lacunarityX + lacunarityY)

    local integralOctave, fractionalOctave = modf(octave)
    local amplitude = 1

    local totalNoise = 0
    local totalAmplitude = 0

    for i = 1, integralOctave do
        totalNoise = totalNoise + amplitude * noise(x, y)
        totalAmplitude = totalAmplitude + amplitude

        x = x * lacunarityX
        y = y * lacunarityY

        amplitude = amplitude * gain
    end

    if fractionalOctave > 0 then
        totalNoise = totalNoise + fractionalOctave * amplitude * noise(x, y)
        totalAmplitude = totalAmplitude + fractionalOctave * amplitude
    end

    return totalNoise / totalAmplitude
end

local function fbm3(
    x, y, z, noise, octave, lacunarityX, lacunarityY, lacunarityZ, gain)

    noise = noise or love.math.noise
    octave = octave or 3

    lacunarityX = lacunarityX or 2
    lacunarityY = lacunarityY or 2
    lacunarityZ = lacunarityZ or 2

    gain = gain or 3 / (lacunarityX + lacunarityY + lacunarityZ)

    local integralOctave, fractionalOctave = modf(octave)
    local amplitude = 1

    local totalNoise = 0
    local totalAmplitude = 0

    for i = 1, integralOctave do
        totalNoise = totalNoise + amplitude * noise(x, y, z)
        totalAmplitude = totalAmplitude + amplitude

        x = x * lacunarityX
        y = y * lacunarityY
        z = z * lacunarityZ

        amplitude = amplitude * gain
    end

    if fractionalOctave > 0 then
        totalNoise = totalNoise + fractionalOctave * amplitude * noise(x, y, z)
        totalAmplitude = totalAmplitude + fractionalOctave * amplitude
    end

    return totalNoise / totalAmplitude
end

local function fbm4(
    x, y, z, w,
    noise,
    octave,
    lacunarityX, lacunarityY, lacunarityZ, lacunarityW,
    gain)

    noise = noise or love.math.noise
    octave = octave or 3

    lacunarityX = lacunarityX or 2
    lacunarityY = lacunarityY or 2
    lacunarityZ = lacunarityZ or 2
    lacunarityW = lacunarityW or 2

    gain = gain or 4 / (lacunarityX + lacunarityY + lacunarityZ + lacunarityW)

    local integralOctave, fractionalOctave = modf(octave)
    local amplitude = 1

    local totalNoise = 0
    local totalAmplitude = 0

    for i = 1, integralOctave do
        totalNoise = totalNoise + amplitude * noise(x, y, z, w)
        totalAmplitude = totalAmplitude + amplitude

        x = x * lacunarityX
        y = y * lacunarityY
        z = z * lacunarityZ
        w = w * lacunarityW

        amplitude = amplitude * gain
    end

    if fractionalOctave > 0 then
        totalNoise = totalNoise + fractionalOctave * amplitude * noise(x, y, z, w)
        totalAmplitude = totalAmplitude + fractionalOctave * amplitude
    end

    return totalNoise / totalAmplitude
end

return {
  bounds2 = bounds2,
  clamp = clamp,
  clampLength2 = clampLength2,
  cross2 = cross2,
  decompose2 = decompose2,
  distance2 = distance2,
  dot2 = dot2,
  fbm = fbm,
  fbm2 = fbm2,
  fbm3 = fbm3,
  fbm4 = fbm4,
  length2 = length2,
  mix = mix,
  mix2 = mix2,
  mixAngles = mixAngles,
  mixTransforms = mixTransforms,
  newTransform3 = newTransform3,
  normalize2 = normalize2,
  normalizeAngle = normalizeAngle,
  rectangleVertices = rectangleVertices,
  rotate2 = rotate2,
  sign = sign,
  smoothstep = smoothstep,
  squaredDistance2 = squaredDistance2,
  transformAngle = transformAngle,
  transformPoints2 = transformPoints2,
  transformRadius = transformRadius,
  transformVector2 = transformVector2,
}
