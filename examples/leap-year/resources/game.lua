return {
  domains = {
    {
      domainType = "time",
      class = "heart.event.domains.Time",
    },

    {
      domainType = "arrayImage",
      class = "resources.scripts.domains.ArrayImage",

      filenames = {
        "resources/images/tiles/stoneWall.png",
        "resources/images/tiles/stoneWallTop.png",
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
      class = "resources.scripts.components.SkyManager",
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
      class = "resources.scripts.components.TerrainManager",
    },

    {
      componentType = "position",
      class = "resources.scripts.components.PositionManager",
    },

    {
      componentType = "velocity",
      class = "resources.scripts.components.VelocityManager",
    },

    {
      componentType = "gravity",
      class = "resources.scripts.components.GravityManager",
      defaultGravityY = 32,
    },

    {
      componentType = "box",
      class = "resources.scripts.components.BoxManager",
    },

    {
      componentType = "collider",
      class = "resources.scripts.components.ColliderManager",
    },

    {
      componentType = "sprite",
      class = "heart.graphics.components.SpriteManager",
    },

    {
      componentType = "characterState",
      class = "resources.scripts.components.StateManager",
      defaultState = "standing",
    },

    {
      componentType = "character",
      class = "resources.scripts.components.CharacterManager",
    },
  },

  systems = {
    debugDraw = {
      -- {
      --   class = "resources.scripts.systems.debugDraw.DebugDrawTerrains",
      -- },

      -- {
      --   class = "resources.scripts.systems.debugDraw.DebugDrawBoxes",
      -- },
    },

    draw = {
      {
        class = "resources.scripts.systems.draw.DrawSkies",
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
        class = "resources.scripts.systems.drawWorld.DrawWorldTerrains",
      },
    },

    fixedUpdate = {
      {
        class = "heart.animation.systems.fixedUpdate.FixedUpdateBones",
      },

      {
        class = "resources.scripts.systems.fixedUpdate.FixedUpdateVelocities",
      },

      {
        class = "resources.scripts.systems.fixedUpdate.FixedUpdatePlayerInputs",
      },

      {
        class = "resources.scripts.systems.fixedUpdate.FixedUpdateCharacterInputs",
      },

      {
        class = "resources.scripts.systems.fixedUpdate.FixedUpdateCharacterStates",
      },

      {
        class = "resources.scripts.systems.fixedUpdate.FixedUpdateGravities",
      },

      {
        class = "resources.scripts.systems.fixedUpdate.FixedUpdateColliders",
      },

      {
        class = "resources.scripts.systems.fixedUpdate.FixedUpdateCollisions",
      },

      {
        class = "resources.scripts.systems.fixedUpdate.FixedUpdateCharacterCollisions",
      },

      {
        class = "resources.scripts.systems.fixedUpdate.FixedUpdateCharacterAnimations",
      },

      {
        class = "resources.scripts.systems.fixedUpdate.FixedUpdateCameras",
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
