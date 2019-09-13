local get2 = heart.table.get2
local max = math.max
local set2 = heart.table.set2

local TerrainComponentManager = heart.class.newClass()

function TerrainComponentManager:init(game, config)
  self.game = assert(game)
  self.tileGrids = {}

  self.defaultTileSymbols = {
    brick = "#",
    ceilingSpikes = "W",
    cloud = "&",
    column = "|",
    dirt = "@",
    floorSpikes = "M",
    leftSign = "<",
    rightSign = ">",
    stone = "%",
    wood = "=",
  }

  self.rewriteHandlers = {
    brick = self.rewriteBrick,
    cloud = self.rewriteCloud,
    column = self.rewriteColumn,
    dirt = self.rewriteDirt,
    largeOrangeTree = self.rewriteLargeOrangeTree,
    stone = self.rewriteStone,
    wood = self.rewriteWood,
  }
end

function TerrainComponentManager:createComponent(id, config, transform)
  local legend = {}

  for tileType, symbol in pairs(self.defaultTileSymbols) do
    legend[symbol] = tileType
  end

  if config.tileSymbols then
    for tileType, symbol in pairs(config.tileSymbols) do
      legend[symbol] = tileType
    end
  end

  local tileGrid = {}

  local width = 0
  local height = 0

  if config.tileGrid then
    height = #config.tileGrid

    for y, line in pairs(config.tileGrid) do
      width = max(width, #line)

      for x = 1, #line do
        local symbol = line:sub(x, x)
        local tileType = legend[symbol]
        set2(tileGrid, y, x, tileType)
      end
    end
  end

  local rewriteHandlers = self.rewriteHandlers

  for y, row in pairs(tileGrid) do
    for x, tileType in pairs(row) do
      local handler = rewriteHandlers[tileType]

      if handler then
        handler(self, tileGrid, x, y, width, height)
      end
    end
  end

  self.tileGrids[id] = tileGrid
end

function TerrainComponentManager:destroyComponent(id)
  self.tileGrids[id] = nil
end

function TerrainComponentManager:rewriteBrick(tileGrid, x, y, width, height)
  if (get2(tileGrid, y - 1, x) ~= "brick" and
    get2(tileGrid, y - 1, x) ~= "brickFloor") then

    set2(tileGrid, y, x, "brickFloor")
  end
end

function TerrainComponentManager:rewriteCloud(tileGrid, x, y, width, height)
  if y > 1 and not get2(tileGrid, y - 1, x) then
    set2(tileGrid, y - 1, x, "cloudFloor")
  end

  if y < height and not get2(tileGrid, y + 1, x) then
    set2(tileGrid, y + 1, x, "cloudCeiling")
  end
end

function TerrainComponentManager:rewriteColumn(tileGrid, x, y, width, height)
  local ceilingColumn = (get2(tileGrid, y - 1, x) ~= "column" and
    get2(tileGrid, y - 1, x) ~= "ceilingColumn")

  local floorColumn = (get2(tileGrid, y + 1, x) ~= "column" and
    get2(tileGrid, y + 1, x) ~= "floorColumn")

  if ceilingColumn ~= floorColumn then
    set2(tileGrid, y, x, ceilingColumn and "ceilingColumn" or "floorColumn")
  end
end

function TerrainComponentManager:rewriteDirt(tileGrid, x, y, width, height)
  if (get2(tileGrid, y - 1, x) ~= "dirt" and
    get2(tileGrid, y - 1, x) ~= "dirtFloor") then

    set2(tileGrid, y, x, "dirtFloor")
  end
end

function TerrainComponentManager:rewriteLargeOrangeTree(
  tileGrid, x, y, width, height)

  if (get2(tileGrid, y, x + 1) == "largeOrangeTree" and
    get2(tileGrid, y + 1, x) == "largeOrangeTree" and
    get2(tileGrid, y + 1, x + 1) == "largeOrangeTree") then

    set2(tileGrid, y, x, "largeOrangeTree11")
    set2(tileGrid, y, x + 1, "largeOrangeTree12")

    set2(tileGrid, y + 1, x, "largeOrangeTree21")
    set2(tileGrid, y + 1, x + 1, "largeOrangeTree22")
  end
end

function TerrainComponentManager:rewriteStone(tileGrid, x, y, width, height)
  if (get2(tileGrid, y - 1, x) ~= "stone" and
    get2(tileGrid, y - 1, x) ~= "stoneFloor") then

    set2(tileGrid, y, x, "stoneFloor")
  end
end

function TerrainComponentManager:rewriteWood(tileGrid, x, y, width, height)
  if (get2(tileGrid, y - 1, x) ~= "wood" and
    get2(tileGrid, y - 1, x) ~= "woodenFloor") then

    set2(tileGrid, y, x, "woodenFloor")
  end
end

return TerrainComponentManager
