local class = require("heart.class")
local heartMath = require("heart.math")
local physicsUtils = require("heart.physics.utils")

local M = class.newClass()

-- See: http://www.mvps.org/directx/articles/catmull/
local function evaluateSpline(x0, y0, x1, y1, x2, y2, x3, y3, t)
  local x = 0.5 * (
    (2 * x1) +
    (-x0 + x2) * t +
    (2 * x0 - 5 * x1 + 4 * x2 - x3) * t * t +
    (-x0 + 3 * x1 - 3 * x2 + x3) * t * t * t)

  local y = 0.5 * (
    (2 * y1) +
    (-y0 + y2) * t +
    (2 * y0 - 5 * y1 + 4 * y2 - y3) * t * t +
    (-y0 + 3 * y1 - 3 * y2 + y3) * t * t * t)

  return x, y
end

local function addPointWithMinDistance(points, x, y, minDistance)
  local squaredDistance = math.huge

  if #points >= 2 then
    local x0 = points[#points - 1]
    local y0 = points[#points]

    squaredDistance = (x - x0) * (x - x0) + (y - y0) * (y - y0)
  end

  if squaredDistance > minDistance * minDistance then
    points[#points + 1] = x
    points[#points + 1] = y
  end
end

local function renderSpline(points, depth, minDistance)
  depth = depth or 5
  minDistance = minDistance or 0.005

  local count = 2 ^ depth
  local result = {}

  for i = 1, #points - 2, 2 do
    local x1 = points[i]
    local y1 = points[i + 1]

    local x2 = points[i + 2]
    local y2 = points[i + 3]

    local x0 = points[i - 2] or x1
    local y0 = points[i - 1] or y1

    local x3 = points[i + 4] or x2
    local y3 = points[i + 5] or y2

    addPointWithMinDistance(result, x1, y1, minDistance)

    for j = 1, count - 1 do
      local t = j / count
      local x, y = evaluateSpline(x0, y0, x1, y1, x2, y2, x3, y3, t)
      addPointWithMinDistance(result, x, y, minDistance)
    end
  end

  addPointWithMinDistance(result, points[#points - 1], points[#points], minDistance)
  return result
end

function M:init(engine, config)
  self.engine = assert(engine)
  self.physicsDomain = assert(self.engine.domains.physics)
  self.transformComponents = assert(self.engine.componentManagers.transform)
end

function M:createComponent(entityId, config)
  local transform = self.transformComponents:getTransform(entityId)

  local bodyId = assert(self.engine:findAncestorComponent(entityId, "body"))
  local body = self.physicsDomain.bodies[bodyId]
  local loop = config.loop == true

  local points = assert(config.points)
  points = renderSpline(points, 5)

  local worldPoints = heartMath.transformPoints2(transform, points)
  local localPoints = physicsUtils.getLocalPoints(body, worldPoints)

  local shape = love.physics.newChainShape(loop, localPoints)
  local density = config.density or 1
  local fixture = love.physics.newFixture(body, shape, density)
  fixture:setUserData(entityId)
  fixture:setFriction(config.friction or 0.2)
  fixture:setRestitution(config.restitution or 0)
  fixture:setGroupIndex(config.groupIndex or 0)
  fixture:setSensor(config.sensor or false)
  self.physicsDomain.chainFixtures[entityId] = fixture
  return fixture
end

function M:destroyComponent(entityId)
  self.physicsDomain.chainFixtures[entityId]:destroy()
  self.physicsDomain.chainFixtures[entityId] = nil
end

return M
