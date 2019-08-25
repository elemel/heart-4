local utils = require("resources.scripts.utils")

local boxDistance = utils.boxDistance
local clear = heart.table.clear
local floor = math.floor
local insert = table.insert
local set2 = heart.table.set2
local sort = table.sort
local squaredDistance2 = heart.math.squaredDistance2

local CollisionFixedUpdateSystem = heart.class.newClass()

function CollisionFixedUpdateSystem:init(game, config)
  self.game = assert(game)

  self.colliderEntities = assert(self.game.componentEntitySets.collider)
  self.colliderComponents = assert(self.game.componentManagers.collider)
  self.positionComponents = assert(self.game.componentManagers.position)
  self.boxComponents = assert(self.game.componentManagers.box)

  self.terrainComponents = assert(self.game.componentManagers.terrain)
end

function CollisionFixedUpdateSystem:fixedUpdate(dt)
  local xs = self.positionComponents.xs
  local ys = self.positionComponents.ys

  local widths = self.boxComponents.widths
  local heights = self.boxComponents.heights

  local constraintMaps = self.colliderComponents.constraintMaps

  for colliderId, map in pairs(constraintMaps) do
    clear(map)
  end

  for terrainId, tileGrid in pairs(self.terrainComponents.tileGrids) do
    for colliderId in pairs(self.colliderEntities) do
      local constraintMap = constraintMaps[colliderId]

      local x = xs[colliderId]
      local y = ys[colliderId]

      local width = widths[colliderId]
      local height = heights[colliderId]

      local tilePositions = {}
      local tileDistances = {}
      local tileIndices = {}

      for tileY = floor(y - 0.5 * height), floor(y + 0.5 * height) do
        local tileRow = tileGrid[tileY]

        if tileRow then
          for tileX = floor(x - 0.5 * width), floor(x + 0.5 * width) do
            if tileRow[tileX] and tileRow[tileX] ~= "grass" and tileRow[tileX] ~= "column" and tileRow[tileX] ~= "ceilingColumn" and tileRow[tileX] ~= "floorColumn" and tileRow[tileX] ~= "ceilingSpikes" and tileRow[tileX] ~= "floorSpikes"  and tileRow[tileX] ~= "leftSign" and tileRow[tileX] ~= "rightSign" then
              insert(tilePositions, tileX)
              insert(tilePositions, tileY)

              local distance = squaredDistance2(
                xs[colliderId], ys[colliderId], tileX + 0.5, tileY + 0.5)

              insert(tileDistances, distance)
              insert(tileIndices, #tileIndices + 1)
            end
          end
        end
      end

      sort(tileIndices, function(a, b)
        return tileDistances[a] < tileDistances[b]
      end)

      for _, i in pairs(tileIndices) do
        local tileX = tilePositions[2 * i - 1]
        local tileY = tilePositions[2 * i]

        local distance, normalX, normalY, direction = boxDistance(
          x - 0.5 * width, y - 0.5 * height, x + 0.5 * width, y + 0.5 * height,
          tileX, tileY, tileX + 1, tileY + 1)

        if distance < -0.001 then
          x = x + distance * normalX
          y = y + distance * normalY

          xs[colliderId] = x
          ys[colliderId] = y

          constraintMap[direction] = {"terrain", terrainId, tileX, tileY}
        end
      end
    end
  end
end

return CollisionFixedUpdateSystem
