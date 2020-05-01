return {
  domains = {
    {
      domainType = "time",
      class = "heart.event.domains.Time",
    },

    {
      domainType = "arrayImage",
      class = "assets.scripts.domains.ArrayImage",

      filenames = {
        "assets/images/tiles/stoneWall.png",
        "assets/images/tiles/stoneWallTop.png",
      },
    },
  },

  componentManagers = {
    {
      componentType = "player",
      class = "heart.components.CategoryManager",
    },

    {
      componentType = "transform",
      class = "heart.animation.components.TransformManager",
    },

    {
      componentType = "sky",
      class = "assets.scripts.components.SkyManager",
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
      class = "assets.scripts.components.TerrainManager",
    },

    {
      componentType = "position",
      class = "assets.scripts.components.PositionManager",
    },

    {
      componentType = "velocity",
      class = "assets.scripts.components.VelocityManager",
    },

    {
      componentType = "gravity",
      class = "assets.scripts.components.GravityManager",
      defaultGravityY = 32,
    },

    {
      componentType = "box",
      class = "assets.scripts.components.BoxManager",
    },

    {
      componentType = "collider",
      class = "assets.scripts.components.ColliderManager",
    },

    {
      componentType = "sprite",
      class = "heart.graphics.components.SpriteManager",
    },

    {
      componentType = "characterState",
      class = "assets.scripts.components.StateManager",
      defaultState = "standing",
    },

    {
      componentType = "character",
      class = "assets.scripts.components.CharacterManager",
    },
  },

  systems = {
    debugDraw = {
      -- {
      --   class = "assets.scripts.systems.debugDraw.DebugDrawTerrains",
      -- },

      -- {
      --   class = "assets.scripts.systems.debugDraw.DebugDrawBoxes",
      -- },
    },

    draw = {
      {
        class = "assets.scripts.systems.draw.DrawSkies",
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
        class = "assets.scripts.systems.drawWorld.DrawWorldTerrains",
      },
    },

    fixedUpdate = {
      {
        class = "heart.animation.systems.fixedUpdate.FixedUpdateBones",
      },

      {
        class = "assets.scripts.systems.fixedUpdate.FixedUpdateVelocities",
      },

      {
        class = "assets.scripts.systems.fixedUpdate.FixedUpdatePlayerInputs",
      },

      {
        class = "assets.scripts.systems.fixedUpdate.FixedUpdateCharacterInputs",
      },

      {
        class = "assets.scripts.systems.fixedUpdate.FixedUpdateCharacterStates",
      },

      {
        class = "assets.scripts.systems.fixedUpdate.FixedUpdateGravities",
      },

      {
        class = "assets.scripts.systems.fixedUpdate.FixedUpdateColliders",
      },

      {
        class = "assets.scripts.systems.fixedUpdate.FixedUpdateCollisions",
      },

      {
        class = "assets.scripts.systems.fixedUpdate.FixedUpdateCharacterCollisions",
      },

      {
        class = "assets.scripts.systems.fixedUpdate.FixedUpdateCharacterAnimations",
      },

      {
        class = "assets.scripts.systems.fixedUpdate.FixedUpdateCameras",
      },
    },

    resize = {
      {
        class = "heart.graphics.systems.resize.ResizeViewports",
      },
    },

    update = {
      {
        class = "heart.event.systems.update.UpdateTime",
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
