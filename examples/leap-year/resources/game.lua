return {
  domains = {
    {
      domainType = "time",
      class = "heart.event.TimeDomain",
    },

    {
      domainType = "arrayImage",
      class = "resources.scripts.ArrayImageDomain",

      filenames = {
        "resources/images/tiles/stoneWall.png",
        "resources/images/tiles/stoneWallTop.png",
      },
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
      class = "resources.scripts.SkyComponentManager",
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
      class = "resources.scripts.TerrainComponentManager",
    },

    {
      componentType = "position",
      class = "resources.scripts.PositionComponentManager",
    },

    {
      componentType = "velocity",
      class = "resources.scripts.VelocityComponentManager",
    },

    {
      componentType = "gravity",
      class = "resources.scripts.GravityComponentManager",
      defaultGravityY = 32,
    },

    {
      componentType = "box",
      class = "resources.scripts.BoxComponentManager",
    },

    {
      componentType = "collider",
      class = "resources.scripts.ColliderComponentManager",
    },

    {
      componentType = "sprite",
      class = "heart.graphics.SpriteComponentManager",
    },

    {
      componentType = "characterState",
      class = "resources.scripts.StateComponentManager",
      defaultState = "standing",
    },

    {
      componentType = "character",
      class = "resources.scripts.CharacterComponentManager",
    },
  },

  systems = {
    debugDraw = {
      -- {
      --   class = "resources.scripts.TerrainDebugDrawSystem",
      -- },

      -- {
      --   class = "resources.scripts.BoxDebugDrawSystem",
      -- },
    },

    draw = {
      {
        class = "resources.scripts.SkyDrawSystem",
      },

      {
        class = "heart.graphics.ViewportDrawSystem",
      },
    },

    drawWorld = {
      {
        class = "heart.graphics.SpriteDrawWorldSystem",
      },

      {
        class = "resources.scripts.TerrainDrawWorldSystem",
      },
    },

    fixedUpdate = {
      {
        class = "resources.scripts.VelocityFixedUpdateSystem",
      },

      {
        class = "resources.scripts.PlayerInputFixedUpdateSystem",
      },

      {
        class = "resources.scripts.CharacterInputFixedUpdateSystem",
      },

      {
        class = "resources.scripts.CharacterStateFixedUpdateSystem",
      },

      {
        class = "resources.scripts.GravityFixedUpdateSystem",
      },

      {
        class = "resources.scripts.ColliderFixedUpdateSystem",
      },

      {
        class = "resources.scripts.CollisionFixedUpdateSystem",
      },

      {
        class = "resources.scripts.CharacterCollisionFixedUpdateSystem",
      },

      {
        class = "resources.scripts.CharacterAnimationFixedUpdateSystem",
      },

      {
        class = "resources.scripts.CameraFixedUpdateSystem",
      },
    },

    resize = {
      {
        class = "heart.graphics.ViewportResizeSystem",
      },
    },

    update = {
      {
        class = "heart.event.TimeUpdateSystem",
      },

      {
        class = "heart.graphics.SpriteUpdateSystem",
      },

      {
        class = "heart.graphics.CameraUpdateSystem",
      },
    },
  },
}
