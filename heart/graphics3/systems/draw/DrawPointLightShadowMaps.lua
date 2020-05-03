
local class = require("heart.class")
local heartTable = require("heart.table")

local M = class.newClass()

function M:init(game, config)
  self.game = assert(game)
  self.fixedTimeStepDomain = assert(self.game.domains.fixedTimeStep)
  self.bones = assert(self.game.componentManagers.bone)
  self.pointLights = assert(self.game.componentManagers.pointLight)
  self.pointLightEntities = assert(self.game.componentEntitySets.pointLight)
  self.meshManager = assert(self.game.componentManagers.mesh)
  self.meshEntities = assert(self.game.componentEntitySets.mesh)

  local vertexShaderCode = [[
    uniform float TimeStepFraction;
    uniform mat4 Transform;
    uniform mat4 PreviousTransform;

    vec4 position(mat4 transform_projection, vec4 vertex_position)
    {
      vec3 pixelPosition =
        mix(
          vec3(PreviousTransform * vertex_position),
          vec3(Transform * vertex_position),
          TimeStepFraction);

      return transform_projection * vec4(pixelPosition, 1.0);
    }
  ]]

  self.shader = love.graphics.newShader(vertexShaderCode)
end

function M:__call()
  local timeStepFraction =
    self.fixedTimeStepDomain.accumulatedTimeStep /
    self.fixedTimeStepDomain.fixedTimeStep

  love.graphics.setDepthMode("less", true)
  love.graphics.setShader(self.shader)
  self.shader:send("TimeStepFraction", timeStepFraction)

  for pointLightEntityId in pairs(self.pointLightEntities) do
    for meshEntityId in pairs(self.meshEntities) do
      self.shader:send("PreviousTransform", self.bones.previousTransforms[meshEntityId])
      self.shader:send("Transform", self.bones.transforms[meshEntityId])
      local mesh = self.meshManager.meshes[meshEntityId]
      love.graphics.draw(mesh)
    end
  end

  love.graphics.setShader(nil)
  love.graphics.setDepthMode()
end

return M
