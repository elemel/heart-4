local utils = require("resources.scripts.utils")

local boxDistance = utils.boxDistance
local clear = heart.table.clear
local floor = math.floor
local insert = table.insert
local get2 = heart.table.get2
local set2 = heart.table.set2
local sort = table.sort
local squaredDistance2 = heart.math.squaredDistance2

local CollisionFixedUpdateSystem = heart.class.newClass()

function CollisionFixedUpdateSystem:init(game, config)
  self.game = assert(game)

  self.colliderEntities = assert(self.game.componentEntitySets.collider)
  self.colliderComponents = assert(self.game.componentManagers.collider)
  self.positionComponents = assert(self.game.componentManagers.position)
  self.velocityComponents = assert(self.game.componentManagers.velocity)
  self.boxComponents = assert(self.game.componentManagers.box)

  self.terrainComponents = assert(self.game.componentManagers.terrain)

  self.wallTileTypes = {dirt = true, dirtFloor = true, stone = true, stoneFloor = true}
end

function CollisionFixedUpdateSystem:fixedUpdate(dt)
  local xs = self.positionComponents.xs
  local ys = self.positionComponents.ys

  local previousXs = self.velocityComponents.previousXs
  local previousYs = self.velocityComponents.previousYs

  local widths = self.boxComponents.widths
  local heights = self.boxComponents.heights

  local constraintMaps = self.colliderComponents.constraintMaps
  local wallTileTypes = self.wallTileTypes

  for colliderId, map in pairs(constraintMaps) do
    clear(map)
  end

  for terrainId, tileGrid in pairs(self.terrainComponents.tileGrids) do
    for colliderId in pairs(self.colliderEntities) do
      local constraintMap = constraintMaps[colliderId]

      local width = widths[colliderId]
      local height = heights[colliderId]

      local x = xs[colliderId]
      local y = previousYs[colliderId]

      if x < previousXs[colliderId] then
        local tileX = floor(x - 0.5 * width + 0.001) + 1

        for tileY = floor(y - 0.5 * height + 0.001) + 1, floor(y + 0.5 * height - 0.001) + 1 do
          local tileType = get2(tileGrid, tileY, tileX)

          if tileType and wallTileTypes[tileType] then
            constraintMap.left = {"terrain", terrainId, tileX, tileY}
            xs[colliderId] = tileX + 0.5 * width
            break
          end
        end
      else
        local tileX = floor(x + 0.5 * width - 0.001) + 1

        for tileY = floor(y - 0.5 * height + 0.001) + 1, floor(y + 0.5 * height - 0.001) + 1 do
          local tileType = get2(tileGrid, tileY, tileX)

          if tileType and wallTileTypes[tileType] then
            constraintMap.right = {"terrain", terrainId, tileX, tileY}
            xs[colliderId] = tileX - 1 - 0.5 * width
            break
          end
        end
      end

      local x = xs[colliderId]
      local y = ys[colliderId]

      if y < previousYs[colliderId] then
        local tileY = floor(y - 0.5 * height + 0.001) + 1

        for tileX = floor(x - 0.5 * width + 0.001) + 1, floor(x + 0.5 * width - 0.001) + 1 do
          local tileType = get2(tileGrid, tileY, tileX)

          if tileType and wallTileTypes[tileType] then
            constraintMap.up = {"terrain", terrainId, tileX, tileY}
            ys[colliderId] = tileY + 0.5 * height
            break
          end
        end
      else
        local tileY = floor(y + 0.5 * height - 0.001) + 1

        for tileX = floor(x - 0.5 * width + 0.001) + 1, floor(x + 0.5 * width - 0.001) + 1 do
          local tileType = get2(tileGrid, tileY, tileX)

          if tileType and wallTileTypes[tileType] then
            constraintMap.down = {"terrain", terrainId, tileX, tileY}
            ys[colliderId] = tileY - 1 - 0.5 * height
            break
          end
        end
      end
    end
  end
end

return CollisionFixedUpdateSystem
