return {
  domains = {
    {
      domainType = "timer",
      class = "heart.timer.domains.TimerDomain",
    },

    {
      domainType = "arrayImage",
      class = "domains.ArrayImageDomain",

      filenames = {
        "assets/images/tiles/stoneWall.png",
        "assets/images/tiles/stoneWallTop.png",
      },
    },
  },

  componentManagers = {
    {
      componentType = "player",
      class = "heart.taxonomy.components.CategoryManager",
    },

    {
      componentType = "transform",
      class = "heart.animation.components.TransformManager",
    },

    {
      componentType = "sky",
      class = "components.SkyManager",
    },

    {
      componentType = "bone",
      class = "heart.animation.components.BoneManager",
    },

    {
      componentType = "camera",
      class = "heart.graphics.components.CameraManager",
    },

    {
      componentType = "viewport",
      class = "heart.graphics.components.ViewportManager",
    },

    {
      componentType = "terrain",
      class = "components.TerrainManager",
    },

    {
      componentType = "position",
      class = "components.PositionManager",
    },

    {
      componentType = "velocity",
      class = "components.VelocityManager",
    },

    {
      componentType = "gravity",
      class = "components.GravityManager",
      defaultGravityY = 32,
    },

    {
      componentType = "box",
      class = "components.BoxManager",
    },

    {
      componentType = "collider",
      class = "components.ColliderManager",
    },

    {
      componentType = "sprite",
      class = "heart.graphics.components.SpriteManager",
    },

    {
      componentType = "characterState",
      class = "heart.taxonomy.components.StateManager",
      defaultState = "standing",
    },

    {
      componentType = "character",
      class = "components.CharacterManager",
    },
  },

  systems = {
    debugdraw = {
      -- {
      --   class = "systems.debugdraw.TerrainDebugDrawSystem",
      -- },

      -- {
      --   class = "systems.debugdraw.BoxDebugDrawSystem",
      -- },
    },

    draw = {
      {
        class = "systems.draw.SkyDrawSystem",
      },

      {
        class = "heart.graphics.systems.draw.ViewportDrawSystem",
      },
    },

    drawworld = {
      {
        class = "heart.graphics.systems.drawworld.SpriteDrawWorldSystem",
      },

      {
        class = "systems.drawworld.TerrainDrawWorldSystem",
      },
    },

    fixedupdate = {
      {
        class = "heart.animation.systems.fixedupdate.PreviousBoneTransformFixedUpdateSystem",
      },

      {
        class = "systems.fixedupdate.VelocityFixedUpdateSystem",
      },

      {
        class = "systems.fixedupdate.PlayerInputFixedUpdateSystem",
      },

      {
        class = "systems.fixedupdate.CharacterInputFixedUpdateSystem",
      },

      {
        class = "systems.fixedupdate.CharacterStateFixedUpdateSystem",
      },

      {
        class = "systems.fixedupdate.GravityFixedUpdateSystem",
      },

      {
        class = "systems.fixedupdate.ColliderFixedUpdateSystem",
      },

      {
        class = "systems.fixedupdate.CollisionFixedUpdateSystem",
      },

      {
        class = "systems.fixedupdate.CharacterCollisionFixedUpdateSystem",
      },

      {
        class = "systems.fixedupdate.CharacterAnimationFixedUpdateSystem",
      },

      {
        class = "systems.fixedupdate.CameraFromPlayerFixedUpdateSystem",
      },
    },

    resize = {
      {
        class = "heart.graphics.systems.resize.ViewportResizeSystem",
      },
    },

    update = {
      {
        class = "heart.timer.systems.update.TimerUpdateSystem",
      },

      {
        class = "heart.graphics.systems.update.SpriteFromBoneUpdateSystem",
      },

      {
        class = "heart.graphics.systems.update.CameraFromBoneUpdateSystem",
      },
    },
  },
}
