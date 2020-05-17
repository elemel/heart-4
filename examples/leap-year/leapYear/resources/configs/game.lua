return {
  domains = {
    {
      domainType = "timer",
      class = "heart.TimerDomain",
    },

    {
      domainType = "arrayImage",
      class = "leapYear.ArrayImageDomain",
    },
  },

  componentManagers = {
    {
      componentType = "player",
      class = "heart.CategoryComponentManager",
    },

    {
      componentType = "transform",
      class = "heart.animation.TransformComponentManager",
    },

    {
      componentType = "sky",
      class = "leapYear.SkyComponentManager",
    },

    {
      componentType = "bone",
      class = "heart.animation.BoneComponentManager",
    },

    {
      componentType = "camera",
      class = "heart.graphics.CameraComponentManager",
    },

    {
      componentType = "viewport",
      class = "heart.graphics.ViewportComponentManager",
    },

    {
      componentType = "terrain",
      class = "leapYear.TerrainComponentManager",
    },

    {
      componentType = "position",
      class = "leapYear.physics.PositionComponentManager",
    },

    {
      componentType = "velocity",
      class = "leapYear.physics.VelocityComponentManager",
    },

    {
      componentType = "gravity",
      class = "leapYear.physics.GravityComponentManager",
      defaultGravityY = 32,
    },

    {
      componentType = "box",
      class = "leapYear.physics.BoxComponentManager",
    },

    {
      componentType = "collider",
      class = "leapYear.physics.ColliderComponentManager",
    },

    {
      componentType = "sprite",
      class = "heart.graphics.SpriteComponentManager",
    },

    {
      componentType = "characterState",
      class = "heart.StateComponentManager",
      defaultState = "standing",
    },

    {
      componentType = "character",
      class = "leapYear.character.CharacterComponentManager",
    },
  },

  systems = {
    debugdraw = {
      -- {
      --   class = "heart.graphics.SpriteDebugDrawSystem",
      -- },

      -- {
      --   class = "leapYear.TerrainDebugDrawSystem",
      -- },

      -- {
      --   class = "leapYear.physics.BoxDebugDrawSystem",
      -- },
    },

    draw = {
      {
        class = "leapYear.SkyDrawSystem",
      },

      {
        class = "heart.graphics.ViewportDrawSystem",
      },
    },

    drawworld = {
      {
        class = "heart.graphics.SpriteDrawWorldSystem",
      },

      {
        class = "leapYear.TerrainDrawWorldSystem",
      },
    },

    fixedupdate = {
      {
        class = "heart.animation.PreviousBoneTransformFixedUpdateSystem",
      },

      {
        class = "leapYear.physics.VelocityFixedUpdateSystem",
      },

      {
        class = "leapYear.PlayerInputFixedUpdateSystem",
      },

      {
        class = "leapYear.character.CharacterInputFixedUpdateSystem",
      },

      {
        class = "leapYear.character.CharacterStateFixedUpdateSystem",
      },

      {
        class = "leapYear.physics.GravityFixedUpdateSystem",
      },

      {
        class = "leapYear.physics.ColliderFixedUpdateSystem",
      },

      {
        class = "leapYear.physics.CollisionFixedUpdateSystem",
      },

      {
        class = "leapYear.character.CharacterCollisionFixedUpdateSystem",
      },

      {
        class = "leapYear.character.CharacterAnimationFixedUpdateSystem",
      },

      {
        class = "leapYear.CameraFromPlayerFixedUpdateSystem",
      },
    },

    resize = {
      {
        class = "heart.graphics.ViewportResizeSystem",
      },
    },

    update = {
      {
        class = "heart.TimerUpdateSystem",
      },

      {
        class = "heart.graphics.SpriteFromBoneUpdateSystem",
      },

      {
        class = "heart.graphics.CameraFromBoneUpdateSystem",
      },
    },
  },
}
