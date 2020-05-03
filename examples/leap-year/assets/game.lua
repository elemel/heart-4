return {
  domains = {
    {
      domainType = "timer",
      class = "heart.timer.domains.Timer",
    },

    {
      domainType = "arrayImage",
      class = "leapYear.domains.ArrayImage",

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
      --   class = "leapYear.systems.debugdraw.DebugDrawTerrains",
      -- },

      -- {
      --   class = "leapYear.systems.debugdraw.DebugDrawBoxes",
      -- },
    },

    draw = {
      {
        class = "leapYear.systems.draw.DrawSkies",
      },

      {
        class = "heart.graphics.systems.draw.DrawViewports",
      },
    },

    drawworld = {
      {
        class = "heart.graphics.systems.drawworld.DrawWorldSprites",
      },

      {
        class = "leapYear.systems.drawworld.DrawWorldTerrains",
      },
    },

    fixedupdate = {
      {
        class = "heart.animation.systems.fixedupdate.FixedUpdateBones",
      },

      {
        class = "leapYear.systems.fixedupdate.FixedUpdateVelocities",
      },

      {
        class = "leapYear.systems.fixedupdate.FixedUpdatePlayerInputs",
      },

      {
        class = "leapYear.systems.fixedupdate.FixedUpdateCharacterInputs",
      },

      {
        class = "leapYear.systems.fixedupdate.FixedUpdateCharacterStates",
      },

      {
        class = "leapYear.systems.fixedupdate.FixedUpdateGravities",
      },

      {
        class = "leapYear.systems.fixedupdate.FixedUpdateColliders",
      },

      {
        class = "leapYear.systems.fixedupdate.FixedUpdateCollisions",
      },

      {
        class = "leapYear.systems.fixedupdate.FixedUpdateCharacterCollisions",
      },

      {
        class = "leapYear.systems.fixedupdate.FixedUpdateCharacterAnimations",
      },

      {
        class = "leapYear.systems.fixedupdate.FixedUpdateCameras",
      },
    },

    resize = {
      {
        class = "heart.graphics.systems.resize.ResizeViewports",
      },
    },

    update = {
      {
        class = "heart.timer.systems.update.UpdateTimer",
      },

      {
        class = "heart.graphics.systems.update.UpdateSpritesFromBones",
      },

      {
        class = "heart.graphics.systems.update.UpdateCamerasFromBones",
      },
    },
  },
}
