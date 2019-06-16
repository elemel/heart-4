local class = require("heart.class")
local heartMath = require("heart.math")
local heartTable = require("heart.table")

local Game = class.newClass()

function Game:init(resourceLoaders, config)
  self.emptyConfig = {}
  self.identityTransform = love.math.newTransform()
  self.resourceLoaders = assert(resourceLoaders)
  self.domains = {}

  self.componentManagers = {}
  self.componentIndices = {}

  self.nextEntityId = 1
  self.componentEntitySets = {}
  self.componentCounts = {}
  self.entityComponentSets = {}
  self.entityParents = {}
  self.entityChildSets = {}

  self.eventSystemSets = {}
  self.eventSystemFilenameSets = {}

  if config.domains then
    for i, domainConfig in ipairs(config.domains) do
      local domainType = assert(domainConfig.domainType, "Missing domain type")
      local domainClass = require(domainConfig.class)
      self.domains[domainType] = domainClass.new(self, domainConfig)
    end
  end

  if config.componentManagers then
    for i, managerConfig in ipairs(config.componentManagers) do
      local componentType =
        assert(managerConfig.componentType, "Missing component type")

      local managerClass = require(managerConfig.class)
      local manager = managerClass.new(self, managerConfig)

      self.componentManagers[componentType] = manager
      self.componentIndices[componentType] = i

      self.componentEntitySets[componentType] = {}
      self.componentCounts[componentType] = 0
    end
  end

  if config.systems then
    for eventType, systemConfigs in pairs(config.systems) do
      local systems = {}
      local systemFilenames = {}
      self.eventSystemSets[eventType] = systems
      self.eventSystemFilenameSets[eventType] = systemFilenames

      for i, systemConfig in ipairs(systemConfigs) do
        local systemClass = require(systemConfig.class)
        local system = systemClass.new(self, systemConfig)
        assert(system[eventType], "Missing event handler")
        systems[#systems + 1] = system
        systemFilenames[#systemFilenames + 1] = systemConfig.class
      end
    end
  end

  if config.entities then
    for i, entityConfig in ipairs(config.entities) do
      self:createEntity(nil, entityConfig)
    end
  end
end

function Game:handleEvent(eventType, ...)
  local systems = self.eventSystemSets[eventType]

  if systems then
    local eventTime = love.timer.getTime()
    local systemFilenames = self.eventSystemFilenameSets[eventType]
    local systemTimes = {}
    local result = nil

    for i, system in ipairs(systems) do
      local handler = system[eventType]
      local systemTime = love.timer.getTime()
      result = handler(system, ...)
      systemTime = love.timer.getTime() - systemTime
      systemTimes[#systemTimes + 1] = {systemTime, systemFilenames[i]}

      if result then
        break
      end
    end

    eventTime = love.timer.getTime() - eventTime
    -- print(string.format("%s  %.6f", eventType, eventTime))
    table.sort(systemTimes, function(a, b) return a[1] > b[1] end)

    for i = 1, math.min(#systemTimes, 10) do
      local systemTime, systemFilename = unpack(systemTimes[i])
      -- print(string.format("  %.6f  %s", systemTime, systemFilename))
    end

    return result
  end
end

function Game:generateEntityId()
  local entityId = self.nextEntityId
  self.nextEntityId = self.nextEntityId + 1
  return entityId
end

function Game:createEntity(parentId, config, transform)
  config = self:expandEntityConfig(config)
  transform = transform or self.identityTransform
  local entityId = config.id

  if entityId then
    assert(
      not self.entityParents[entityId] and
      not self.entityChildSets[entityId] and
      not self.entityComponentSets[entityId],
      "Entity already exists")
  else
    entityId = self:generateEntityId()
  end

  parentId = parentId or config.parent
  self:setEntityParent(entityId, parentId)
  local componentConfigs = config.components

  if config.transform then
    local localTransform = love.math.newTransform()

    if config.transform.z then
      localTransform:setMatrix(
        1, 0, 0, 0,
        0, 1, 0, 0,
        0, 0, 1, config.transform.z,
        0, 0, 0, 1)

      transform = transform * localTransform
    end

    localTransform:setTransformation(unpack(config.transform))
    transform = transform * localTransform
  elseif config.transform3 then
    transform = transform * heartMath.newTransform3(unpack(config.transform3))
  end

  if componentConfigs then
    local componentTypes = heartTable.keys(componentConfigs)
    local componentIndices = self.componentIndices

    for i, componentType in ipairs(componentTypes) do
      if not componentIndices[componentType] then
        error("No such component: " .. componentType)
      end
    end

    table.sort(componentTypes, function(a, b)
      return componentIndices[a] < componentIndices[b]
    end)

    for i, componentType in ipairs(componentTypes) do
      local componentConfig = componentConfigs[componentType]
      self:createComponent(entityId, componentType, componentConfig, transform)
    end
  end

  if config.children then
    for i, childConfig in ipairs(config.children) do
      self:createEntity(entityId, childConfig, transform)
    end
  end

  return entityId
end

function Game:destroyEntity(entityId)
  local children = self.entityChildSets[entityId]

  if children then
    local childIds = heartTable.keys(children)
    table.sort(childIds)

    for i = #childIds, 1, -1 do
      self:destroyEntity(childIds[i])
    end
  end

  local components = self.entityComponentSets[entityId]

  if not components then
    return false
  end

  local componentTypes = heartTable.keys(components)
  local componentIndices = self.componentIndices

  table.sort(componentTypes, function(a, b)
    return componentIndices[a] > componentIndices[b]
  end)

  for i, componentType in ipairs(componentTypes) do
    self:destroyComponent(entityId, componentType)
  end

  self:setEntityParent(entityId, nil)
  return true
end

function Game:createComponent(entityId, componentType, config, transform)
  config = config or self.emptyConfig
  transform = transform or self.identityTransform
  local componentManager = self.componentManagers[componentType]

  if not componentManager then
    error("No such component: " .. componentType)
  end

  local components = self.entityComponentSets[entityId]

  if components and components[componentType] then
    error("Component already exists: " .. componentType)
  end

  local component =
    componentManager:createComponent(entityId, config, transform)

  if not components then
    components = {}
    self.entityComponentSets[entityId] = components
  end

  components[componentType] = true
  self.componentEntitySets[componentType][entityId] = true
  self.componentCounts[componentType] = self.componentCounts[componentType] + 1
  return component
end

function Game:destroyComponent(entityId, componentType)
  local componentManager = self.componentManagers[componentType]

  if not componentManager then
    error("No such component: " .. componentType)
  end

  local components = self.entityComponentSets[entityId]

  if not components or not components[componentType] then
    return false
  end

  componentManager:destroyComponent(entityId)
  components[componentType] = nil

  if not next(components) then
    self.entityComponentSets[entityId] = nil
  end

  self.componentEntitySets[componentType][entityId] = nil
  self.componentCounts[componentType] = self.componentCounts[componentType] - 1
  return true
end

function Game:expandEntityConfig(config)
  local prototypeFilename = config.prototype

  if not prototypeFilename then
    return config
  end

  local prototype = require(prototypeFilename)
  prototype = self:expandEntityConfig(prototype)

  local expandedConfig = {
    id = config.id,
    parent = config.parent,
    transform = config.transform,
    transform3 = config.transform3,
  }

  if config.components or prototype.components then
    expandedConfig.components = {}

    if prototype.components then
      for componentType, componentPrototype in pairs(prototype.components) do
        expandedConfig.components[componentType] = componentPrototype
      end
    end

    if config.components then
      for componentType, componentConfig in pairs(config.components) do
        local componentPrototype = expandedConfig.components[componentType]

        if componentPrototype then
          expandedComponentConfig = {}

          for name, value in pairs(componentPrototype) do
            expandedComponentConfig[name] = value
          end

          for name, value in pairs(componentConfig) do
            expandedComponentConfig[name] = value
          end

          componentConfig = expandedComponentConfig
        end

        expandedConfig.components[componentType] = componentConfig
      end
    end
  end

  if config.children or prototype.children then
    expandedConfig.children = {}

    if prototype.children then
      for i, childConfig in ipairs(prototype.children) do
        childConfig = self:expandEntityConfig(childConfig)
        expandedConfig.children[i] = childConfig
      end
    end

    if config.children then
      for i, childConfig in ipairs(config.children) do
        childConfig = self:expandEntityConfig(childConfig)
        expandedConfig.children[i] = childConfig
      end
    end
  end

  return expandedConfig
end

function Game:setEntityParent(entityId, parentId)
  local currentParentId = self.entityParents[entityId]

  if parentId ~= currentParentId then
    if currentParentId then
      local siblings = assert(self.entityChildSets[currentParentId])
      siblings[entityId] = nil

      if not next(siblings) then
        self.entityChildSets[currentParentId] = nil
      end
    end

    self.entityParents[entityId] = parentId

    if parentId then
      local siblings = self.entityChildSets[parentId]

      if not siblings then
        siblings = {}
        self.entityChildSets[parentId] = siblings
      end

      siblings[entityId] = true
    end
  end
end

function Game:findAncestorComponent(
    entityId, componentType, minDistance, maxDistance)

  minDistance = minDistance or 0
  maxDistance = maxDistance or math.huge
  local parents = self.entityParents
  local componentSets = self.entityComponentSets
  local distance = 0

  while entityId and distance < minDistance do
    entityId = parents[entityId]
    distance = distance + 1
  end

  while entityId and distance <= maxDistance do
    local components = componentSets[entityId]

    if components and components[componentType] then
      return entityId
    end

    entityId = parents[entityId]
    distance = distance + 1
  end

  return nil
end

function Game:findDescendantComponents(
    entityId, componentType, minDistance, maxDistance, descendants)

  minDistance = minDistance or 0
  maxDistance = maxDistance or math.huge
  descendants = descendants or {}

  if minDistance <= 0 and maxDistance >= 0 then
    local components = self.entityComponentSets[entityId]

    if components and components[componentType] then
      descendants[#descendants + 1] = entityId
    end
  end

  if maxDistance >= 1 then
    local children = self.entityChildSets[entityId]

    if children then
      for childId in pairs(children) do
        self:findDescendantComponents(
          childId, componentType, minDistance - 1, maxDistance - 1, descendants)
      end
    end
  end

  return descendants
end

return Game
