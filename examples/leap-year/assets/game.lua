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
      --   class = "leapYear.systems.debugdraw.DebugDrawTerrainSystem",
      -- },

      -- {
      --   class = "leapYear.systems.debugdraw.DebugDrawBoxSystem",
      -- },
    },

    draw = {
      {
        class = "leapYear.systems.draw.DrawSkySystem",
      },

      {
        class = "heart.graphics.systems.draw.DrawViewportSystem",
      },
    },

    drawworld = {
      {
        class = "heart.graphics.systems.drawworld.DrawSpriteSystem",
      },

      {
        class = "leapYear.systems.drawworld.DrawTerrainSystem",
      },
    },

    fixedupdate = {
      {
        class = "heart.animation.systems.fixedupdate.UpdatePreviousBoneTransformSystem",
      },

      {
        class = "leapYear.systems.fixedupdate.UpdateVelocitySystem",
      },

      {
        class = "leapYear.systems.fixedupdate.UpdatePlayerInputSystem",
      },

      {
        class = "leapYear.systems.fixedupdate.UpdateCharacterInputSystem",
      },

      {
        class = "leapYear.systems.fixedupdate.UpdateCharacterStateSystem",
      },

      {
        class = "leapYear.systems.fixedupdate.UpdateGravitySystem",
      },

      {
        class = "leapYear.systems.fixedupdate.UpdateColliderSystem",
      },

      {
        class = "leapYear.systems.fixedupdate.UpdateCollisionSystem",
      },

      {
        class = "leapYear.systems.fixedupdate.UpdateCharacterCollisionSystem",
      },

      {
        class = "leapYear.systems.fixedupdate.UpdateCharacterAnimationSystem",
      },

      {
        class = "leapYear.systems.fixedupdate.UpdateCameraFromPlayerSystem",
      },
    },

    resize = {
      {
        class = "heart.graphics.systems.resize.ResizeViewportSystem",
      },
    },

    update = {
      {
        class = "heart.timer.systems.update.UpdateTimerSystem",
      },

      {
        class = "heart.graphics.systems.update.UpdateSpriteFromBoneSystem",
      },

      {
        class = "heart.graphics.systems.update.UpdateCameraFromBoneSystem",
      },
    },
  },
}
