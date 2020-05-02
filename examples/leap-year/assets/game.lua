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
    debugDraw = {
      -- {
      --   class = "leapYear.systems.debugDraw.DebugDrawTerrains",
      -- },

      -- {
      --   class = "leapYear.systems.debugDraw.DebugDrawBoxes",
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

    drawWorld = {
      {
        class = "heart.graphics.systems.drawWorld.DrawWorldSprites",
      },

      {
        class = "leapYear.systems.drawWorld.DrawWorldTerrains",
      },
    },

    fixedUpdate = {
      {
        class = "heart.animation.systems.fixedUpdate.FixedUpdateBones",
      },

      {
        class = "leapYear.systems.fixedUpdate.FixedUpdateVelocities",
      },

      {
        class = "leapYear.systems.fixedUpdate.FixedUpdatePlayerInputs",
      },

      {
        class = "leapYear.systems.fixedUpdate.FixedUpdateCharacterInputs",
      },

      {
        class = "leapYear.systems.fixedUpdate.FixedUpdateCharacterStates",
      },

      {
        class = "leapYear.systems.fixedUpdate.FixedUpdateGravities",
      },

      {
        class = "leapYear.systems.fixedUpdate.FixedUpdateColliders",
      },

      {
        class = "leapYear.systems.fixedUpdate.FixedUpdateCollisions",
      },

      {
        class = "leapYear.systems.fixedUpdate.FixedUpdateCharacterCollisions",
      },

      {
        class = "leapYear.systems.fixedUpdate.FixedUpdateCharacterAnimations",
      },

      {
        class = "leapYear.systems.fixedUpdate.FixedUpdateCameras",
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
