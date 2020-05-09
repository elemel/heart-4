return {
  domains = {
    {
      domainType = "timer",
      class = "heart.timer.domains.TimerDomain",
    },

    {
      domainType = "arrayImage",
      class = "leapYear.domains.ArrayImageDomain",

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
      class = "leapYear.components.SkyManager",
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
      class = "leapYear.components.TerrainManager",
    },

    {
      componentType = "position",
      class = "leapYear.components.PositionManager",
    },

    {
      componentType = "velocity",
      class = "leapYear.components.VelocityManager",
    },

    {
      componentType = "gravity",
      class = "leapYear.components.GravityManager",
      defaultGravityY = 32,
    },

    {
      componentType = "box",
      class = "leapYear.components.BoxManager",
    },

    {
      componentType = "collider",
      class = "leapYear.components.ColliderManager",
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
      class = "leapYear.components.CharacterManager",
    },
  },

  systems = {
    debugdraw = {
      -- {
      --   class = "leapYear.systems.debugdraw.TerrainDebugDrawSystem",
      -- },

      -- {
      --   class = "leapYear.systems.debugdraw.BoxDebugDrawSystem",
      -- },
    },

    draw = {
      {
        class = "leapYear.systems.draw.SkyDrawSystem",
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
        class = "leapYear.systems.drawworld.TerrainDrawWorldSystem",
      },
    },

    fixedupdate = {
      {
        class = "heart.animation.systems.fixedupdate.PreviousBoneTransformFixedUpdateSystem",
      },

      {
        class = "leapYear.systems.fixedupdate.VelocityFixedUpdateSystem",
      },

      {
        class = "leapYear.systems.fixedupdate.PlayerInputFixedUpdateSystem",
      },

      {
        class = "leapYear.systems.fixedupdate.CharacterInputFixedUpdateSystem",
      },

      {
        class = "leapYear.systems.fixedupdate.CharacterStateFixedUpdateSystem",
      },

      {
        class = "leapYear.systems.fixedupdate.GravityFixedUpdateSystem",
      },

      {
        class = "leapYear.systems.fixedupdate.ColliderFixedUpdateSystem",
      },

      {
        class = "leapYear.systems.fixedupdate.CollisionFixedUpdateSystem",
      },

      {
        class = "leapYear.systems.fixedupdate.CharacterCollisionFixedUpdateSystem",
      },

      {
        class = "leapYear.systems.fixedupdate.CharacterAnimationFixedUpdateSystem",
      },

      {
        class = "leapYear.systems.fixedupdate.CameraFromPlayerFixedUpdateSystem",
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
