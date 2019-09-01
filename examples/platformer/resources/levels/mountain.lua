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
      componentType = "gravity",
      class = "heart.CategoryComponentManager",
    },

    {
      componentType = "player",
      class = "heart.CategoryComponentManager",
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
        class = "heart.graphics.ViewportDrawSystem",
      },
    },

    drawWorld = {
      {
        class = "resources.scripts.TerrainDrawWorldSystem",
      },

      {
        class = "heart.graphics.SpriteDrawWorldSystem",
      },
    },

    fixedUpdate = {
      {
        class = "resources.scripts.VelocityFixedUpdateSystem",
      },

      {
        class = "resources.scripts.GravityFixedUpdateSystem",
        gravityY = 32,
      },

      {
        class = "resources.scripts.CharacterFixedUpdateSystem",
      },

      {
        class = "resources.scripts.ColliderFixedUpdateSystem",
      },

      {
        class = "resources.scripts.CollisionFixedUpdateSystem",
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

  entities = {
    {
      transform = {13, 8, 0, 16},

      components = {
        camera = {},
        viewport = {},
      },
    },

    {
      components = {
        terrain = {
          tileGrid = {
            "   &&                                                           ",
            "  &&&& &&                                                       ",
            " &&&&&&&&&                                                      ",
            " &&&&&&&&&&       %%%%%%                                        ",
            "   &&&&&&&&          %%%%%%       %%%                           ",
            "                     %%%%%%      %%%%                           ",
            "               %%%%  %%%%%%      %%%%       %%%%                ",
            "                |    %%%%%%      %%%%%     %%%%%%               ",
            "                |    %%%%%%%    %%%%%%     %%%%%%               ",
            "                | %%%%%%%%%%    %%%%%%%  %%%%%%%%               ",
            "                |  | %%%%%%%%%%%%%%%%%%%%%%%%%%%%               ",
            "                |  |  %%%%%%%%%%%%%%%%%%%%%%%%%%%%              ",
            "         %%%%  %%% |  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        ",
            "         %%%%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      ",
            " >    %%%%%%%MM%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    > ",
            "@@@@@%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%@@@@@",
          },
        },
      },
    },

    {
      transform = {2, -2, 0, 1 / 16, 1 / 16, 8, 8},

      components = {
        gravity = {},
        player = {},
        bone = {},

        position = {
          x = 2.5,
          y = 14.5,
        },

        velocity = {},

        box = {
          width = 0.5,
        },

        collider = {},

        sprite = {
          image = "resources/images/characters/man/idleMan.png",
        },

        characterState = {
          state = "standing",
        },

        character = {
          characterType = "goblin",
        },
      },
    },
  },
}
