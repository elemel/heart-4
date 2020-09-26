return {
  title = "Spider",

  components = {
    player = {},
    transform = {},

    body = {
      bodyType = "dynamic",
    },

    circleFixture = {},
    spider = {},
  },

  children = {
    {
      title = "Tail",

      components = {
        transform = {
          transform = {0, 0.75},
        },

        circleFixture = {
          radius = 0.5,
          sensor = true,
        },
      },
    },

    {
      prototype = "resources.leg",

      components = {
        transform = {
          transform = {0.31180110461345445, -0.20833883738235082},
        },
      },
    },

    {
      prototype = "resources.leg",

      components = {
        transform = {
          transform = {0.3677944801512114, -0.0731588707560481},
        },
      },
    },

    {
      prototype = "resources.leg",

      components = {
        transform = {
          transform = {0.3677944801512114, 0.0731588707560481},
        },
      },
    },

    {
      prototype = "resources.leg",

      components = {
        transform = {
          transform = {0.31180110461345445, 0.20833883738235082},
        },
      },
    },

    {
      prototype = "resources.leg",

      components = {
        transform = {
          transform = {-0.31180110461345445, 0.20833883738235082},
        },
      },
    },

    {
      prototype = "resources.leg",

      components = {
        transform = {
          transform = {-0.3677944801512114, 0.0731588707560481},
        },
      },
    },

    {
      prototype = "resources.leg",

      components = {
        transform = {
          transform = {-0.3677944801512114, -0.0731588707560481},
        },
      },
    },

    {
      prototype = "resources.leg",

      components = {
        transform = {
          transform = {-0.31180110461345445, -0.20833883738235082},
        },
      },
    },
  },
}
