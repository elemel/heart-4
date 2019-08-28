local get2 = heart.table.get2
local set2 = heart.table.set2

local TerrainComponentManager = heart.class.newClass()

function TerrainComponentManager:init(game, config)
  self.game = assert(game)
  self.tileGrids = {}
end

function TerrainComponentManager:createComponent(id, config, transform)
  local tileGrid = {}

  local legend = {
    ["#"] = "brick",
    ["W"] = "ceilingSpikes",
    ["&"] = "cloud",
    ["|"] = "column",
    ["@"] = "dirt",
    ["M"] = "floorSpikes",
    ["<"] = "leftSign",
    [","] = "grass",
    [">"] = "rightSign",
    ["%"] = "stone",
  }

  if config.tileGrid then
    for y, line in pairs(config.tileGrid) do
      for x = 1, #line do
        local char = line:sub(x, x)
        local tileType = legend[char]
        set2(tileGrid, y, x, tileType)
      end
    end
  end

  for y, row in pairs(tileGrid) do
    for x, tileType in pairs(row) do
      if tileType == "cloud" and get2(tileGrid, y - 1, x) ~= "cloud" and get2(tileGrid, y - 1, x) ~= "cloudFloor" then
        row[x] = "cloudFloor"
      end

      if tileType == "cloud" and get2(tileGrid, y + 1, x) ~= "cloud" and get2(tileGrid, y + 1, x) ~= "cloudCeiling" then
        row[x] = "cloudCeiling"
      end

      if tileType == "brick" and get2(tileGrid, y - 1, x) ~= "brick" and get2(tileGrid, y - 1, x) ~= "brickFloor" then
        row[x] = "brickFloor"
      end

      if tileType == "column" and get2(tileGrid, y - 1, x) ~= "column" and get2(tileGrid, y - 1, x) ~= "ceilingColumn" then
        row[x] = "ceilingColumn"
      end

      if tileType == "column" and get2(tileGrid, y + 1, x) ~= "column" and get2(tileGrid, y + 1, x) ~= "floorColumn" then
        row[x] = "floorColumn"
      end

      if tileType == "dirt" and get2(tileGrid, y - 1, x) ~= "dirt" and get2(tileGrid, y - 1, x) ~= "dirtFloor" then
        row[x] = "dirtFloor"
      end

      if tileType == "stone" and get2(tileGrid, y - 1, x) ~= "stone" and get2(tileGrid, y - 1, x) ~= "stoneFloor" then
        row[x] = "stoneFloor"
      end
    end
  end

  self.tileGrids[id] = tileGrid
end

function TerrainComponentManager:destroyComponent(id)
  self.tileGrids[id] = nil
end

return TerrainComponentManager
