local utils = require("leapYear.utils")

local boxDistance = utils.boxDistance
local clear = heart.table.clear
local floor = math.floor
local insert = table.insert
local get2 = heart.table.get2
local set2 = heart.table.set2
local sort = table.sort
local squaredDistance2 = heart.math.squaredDistance2

local M = heart.class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)

  self.colliderEntities = assert(self.engine.componentEntitySets.collider)

  self.boxComponents = assert(self.engine.componentManagers.box)
  self.colliderComponents = assert(self.engine.componentManagers.collider)
  self.positionComponents = assert(self.engine.componentManagers.position)
  self.terrainComponents = assert(self.engine.componentManagers.terrain)
  self.velocityComponents = assert(self.engine.componentManagers.velocity)

  self.wallTileTypes = {
    blueBrick = true,
    blueBrickFloor = true,
    brick = true,
    brickFloor = true,
    cloud = true,
    dirt = true,
    dirtFloor = true,
    greenBrick = true,
    greenBrickFloor = true,
    stone = true,
    stoneFloor = true,
    wood = true,
    woodenFloor = true,
    yellowBrick = true,
    yellowBrickFloor = true,
  }
end

function M:handleEvent(dt)
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

      local tileX = floor(x - 0.5 * width - 0.001) + 1

      for tileY = floor(y - 0.5 * height + 0.001) + 1, floor(y + 0.5 * height - 0.001) + 1 do
        local tileType = get2(tileGrid, tileY, tileX)

        if tileType and wallTileTypes[tileType] then
          constraintMap.left = {"terrain", terrainId, tileX, tileY}
          xs[colliderId] = tileX + 0.5 * width
          break
        end
      end

      local tileX = floor(x + 0.5 * width + 0.001) + 1

      for tileY = floor(y - 0.5 * height + 0.001) + 1, floor(y + 0.5 * height - 0.001) + 1 do
        local tileType = get2(tileGrid, tileY, tileX)

        if tileType and wallTileTypes[tileType] then
          constraintMap.right = {"terrain", terrainId, tileX, tileY}
          xs[colliderId] = tileX - 1 - 0.5 * width
          break
        end
      end

      local x = xs[colliderId]
      local y = ys[colliderId]

      local tileY = floor(y - 0.5 * height - 0.001) + 1

      for tileX = floor(x - 0.5 * width + 0.001) + 1, floor(x + 0.5 * width - 0.001) + 1 do
        local tileType = get2(tileGrid, tileY, tileX)

        if tileType and wallTileTypes[tileType] then
          constraintMap.up = {"terrain", terrainId, tileX, tileY}
          ys[colliderId] = tileY + 0.5 * height
          break
        end
      end

      local tileY = floor(y + 0.5 * height + 0.001) + 1

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

return M
