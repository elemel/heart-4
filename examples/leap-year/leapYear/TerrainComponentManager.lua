local get2 = heart.table.get2
local max = math.max
local set2 = heart.table.set2

local M = heart.class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.tileGrids = {}

  self.defaultTileSymbols = {
    brick = "#",
    ceilingSpikes = "W",
    cloud = "&",
    column = "|",
    dirt = "@",
    floorSpikes = "M",
    grass = ":",
    largeTree = "T",
    leftSign = "<",
    rightSign = ">",
    shortGrass = ".",
    stone = "%",
    tallGrass = "!",
    wood = "="
  }

  self.rewriteHandlers = {
    blueBrick = self.rewriteBlueBrick,
    brick = self.rewriteBrick,
    cloud = self.rewriteCloud,
    column = self.rewriteColumn,
    dirt = self.rewriteDirt,
    greenBrick = self.rewriteGreenBrick,
    largeRedTree = self.rewriteLargeRedTree,
    largeTree = self.rewriteLargeTree,
    largeYellowTree = self.rewriteLargeYellowTree,
    stone = self.rewriteStone,
    wood = self.rewriteWood,
    yellowBrick = self.rewriteYellowBrick,
  }
end

function M:createComponent(id, config)
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

function M:destroyComponent(id)
  self.tileGrids[id] = nil
end

function M:rewriteBlueBrick(tileGrid, x, y, width, height)
  if (get2(tileGrid, y - 1, x) ~= "blueBrick" and
    get2(tileGrid, y - 1, x) ~= "blueBrickFloor") then

    set2(tileGrid, y, x, "blueBrickFloor")
  end
end

function M:rewriteBrick(tileGrid, x, y, width, height)
  if (get2(tileGrid, y - 1, x) ~= "brick" and
    get2(tileGrid, y - 1, x) ~= "brickFloor") then

    set2(tileGrid, y, x, "brickFloor")
  end
end

function M:rewriteCloud(tileGrid, x, y, width, height)
  if y > 1 and not get2(tileGrid, y - 1, x) then
    set2(tileGrid, y - 1, x, "cloudFloor")
  end

  if y < height and not get2(tileGrid, y + 1, x) then
    set2(tileGrid, y + 1, x, "cloudCeiling")
  end
end

function M:rewriteColumn(tileGrid, x, y, width, height)
  local ceilingColumn = (get2(tileGrid, y - 1, x) ~= "column" and
    get2(tileGrid, y - 1, x) ~= "ceilingColumn")

  local floorColumn = (get2(tileGrid, y + 1, x) ~= "column" and
    get2(tileGrid, y + 1, x) ~= "floorColumn")

  if ceilingColumn ~= floorColumn then
    set2(tileGrid, y, x, ceilingColumn and "ceilingColumn" or "floorColumn")
  end
end

function M:rewriteDirt(tileGrid, x, y, width, height)
  if (get2(tileGrid, y - 1, x) ~= "dirt" and
    get2(tileGrid, y - 1, x) ~= "dirtFloor") then

    set2(tileGrid, y, x, "dirtFloor")
  end
end

function M:rewriteGreenBrick(tileGrid, x, y, width, height)
  if (get2(tileGrid, y - 1, x) ~= "greenBrick" and
    get2(tileGrid, y - 1, x) ~= "greenBrickFloor") then

    set2(tileGrid, y, x, "greenBrickFloor")
  end
end

function M:rewriteLargeRedTree(
  tileGrid, x, y, width, height)

  if (get2(tileGrid, y, x + 1) == "largeRedTree" and
    get2(tileGrid, y + 1, x) == "largeRedTree" and
    get2(tileGrid, y + 1, x + 1) == "largeRedTree") then

    set2(tileGrid, y, x, "largeRedTree11")
    set2(tileGrid, y, x + 1, "largeRedTree12")

    set2(tileGrid, y + 1, x, "largeRedTree21")
    set2(tileGrid, y + 1, x + 1, "largeRedTree22")
  end
end

function M:rewriteLargeTree(
  tileGrid, x, y, width, height)

  if (get2(tileGrid, y, x + 1) == "largeTree" and
    get2(tileGrid, y + 1, x) == "largeTree" and
    get2(tileGrid, y + 1, x + 1) == "largeTree") then

    set2(tileGrid, y, x, "largeTree11")
    set2(tileGrid, y, x + 1, "largeTree12")

    set2(tileGrid, y + 1, x, "largeTree21")
    set2(tileGrid, y + 1, x + 1, "largeTree22")
  end
end

function M:rewriteLargeYellowTree(
  tileGrid, x, y, width, height)

  if (get2(tileGrid, y, x + 1) == "largeYellowTree" and
    get2(tileGrid, y + 1, x) == "largeYellowTree" and
    get2(tileGrid, y + 1, x + 1) == "largeYellowTree") then

    set2(tileGrid, y, x, "largeYellowTree11")
    set2(tileGrid, y, x + 1, "largeYellowTree12")

    set2(tileGrid, y + 1, x, "largeYellowTree21")
    set2(tileGrid, y + 1, x + 1, "largeYellowTree22")
  end
end

function M:rewriteStone(tileGrid, x, y, width, height)
  if (get2(tileGrid, y - 1, x) ~= "stone" and
    get2(tileGrid, y - 1, x) ~= "stoneFloor") then

    set2(tileGrid, y, x, "stoneFloor")
  end
end

function M:rewriteWood(tileGrid, x, y, width, height)
  if (get2(tileGrid, y - 1, x) ~= "wood" and
    get2(tileGrid, y - 1, x) ~= "woodenFloor") then

    set2(tileGrid, y, x, "woodenFloor")
  end
end

function M:rewriteYellowBrick(tileGrid, x, y, width, height)
  if (get2(tileGrid, y - 1, x) ~= "yellowBrick" and
    get2(tileGrid, y - 1, x) ~= "yellowBrickFloor") then

    set2(tileGrid, y, x, "yellowBrickFloor")
  end
end

return M
