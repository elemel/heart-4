
local class = require("heart.class")
local table = require("heart.table")

local M = class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)
  self.fixedTimeStepDomain = assert(self.engine.domains.fixedTimeStep)
  self.bones = assert(self.engine.componentManagers.bone)
  self.pointLights = assert(self.engine.componentManagers.pointLight)
  self.pointLightEntities = assert(self.engine.componentEntitySets.pointLight)
  self.meshInstanceComponents = assert(self.engine.componentManagers.mesh)
  self.meshEntities = assert(self.engine.componentEntitySets.mesh)

  self.lightCount = 0
  self.lightPositions = {}
  self.lightColors = {}
  self.lightAttenuations = {}

  local pixelShaderCode = [[
    #define MAX_LIGHT_COUNT 16
    #define PI 3.14159265359

    uniform vec3 AmbientLight;
    uniform int LightCount;
    uniform vec3 LightPositions[MAX_LIGHT_COUNT];
    uniform vec3 LightColors[MAX_LIGHT_COUNT];
    uniform vec3 LightAttenuations[MAX_LIGHT_COUNT];

    varying vec3 VaryingPosition;
    varying vec3 VaryingNormal;

    vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords)
    {
      vec4 textureColor = Texel(texture, texture_coords);
      vec3 lighting = AmbientLight;

      for (int i = 0; i < LightCount; ++i)
      {
        vec3 lightDirection = LightPositions[i] - VaryingPosition;
        float lightDistance = length(lightDirection);
        lightDirection = lightDirection / lightDistance;
        float diffuseFactor = max(dot(VaryingNormal, lightDirection), 0.0);

        float lightAttenuation =
          LightAttenuations[i].x +
          LightAttenuations[i].y * lightDistance +
          LightAttenuations[i].z * lightDistance * lightDistance;

        lighting += LightColors[i] * diffuseFactor / lightAttenuation;
      }

      return vec4(lighting, 1.0) * textureColor * color;
    }
  ]]

  local vertexShaderCode = [[
    uniform float TimeStepFraction;
    uniform mat4 Transform;
    uniform mat4 PreviousTransform;

    attribute vec3 VertexNormal;

    varying vec3 VaryingPosition;
    varying vec3 VaryingNormal;

    vec4 position(mat4 transform_projection, vec4 vertex_position)
    {
      VaryingPosition =
        mix(
          vec3(PreviousTransform * vertex_position),
          vec3(Transform * vertex_position),
          TimeStepFraction);

      VaryingNormal =
        normalize(
          mix(
            mat3(PreviousTransform) * VertexNormal,
            mat3(Transform) * VertexNormal,
            TimeStepFraction));

      return transform_projection * vec4(VaryingPosition, 1.0);
    }
  ]]

  self.shader = love.graphics.newShader(pixelShaderCode, vertexShaderCode)
end

function M:handleEvent(viewportId)
  local timeStepFraction = self.timerDomain:getFraction()

  self.lightCount = 0
  table.clear(self.lightPositions)
  table.clear(self.lightColors)
  table.clear(self.lightAttenuations)

  for entityId in pairs(self.pointLightEntities) do
    self.lightCount = self.lightCount + 1
    self.lightPositions[#self.lightPositions + 1] = self.pointLights.positions[entityId]
    self.lightColors[#self.lightColors + 1] = self.pointLights.colors[entityId]
    self.lightAttenuations[#self.lightAttenuations + 1] = self.pointLights.attenuations[entityId]
  end

  love.graphics.setDepthMode("less", true)
  love.graphics.setShader(self.shader)
  self.shader:send("TimeStepFraction", timeStepFraction)
  self.shader:send("AmbientLight", {0.02, 0.02, 0.02})
  self.shader:send("LightCount", self.lightCount)

  if self.lightCount >= 1 then
    self.shader:send("LightPositions", unpack(self.lightPositions))
    self.shader:send("LightColors", unpack(self.lightColors))
    self.shader:send("LightAttenuations", unpack(self.lightAttenuations))
  end

  for entityId in pairs(self.meshEntities) do
    self.shader:send("PreviousTransform", self.bones.previousTransforms[entityId])
    self.shader:send("Transform", self.bones.transforms[entityId])
    local mesh = self.meshInstanceComponents.meshes[entityId]
    love.graphics.draw(mesh)
  end

  love.graphics.setShader(nil)
  love.graphics.setDepthMode()
end

return M
