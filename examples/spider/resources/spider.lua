return {
  title = "Spider",

  components = {
    player = {},
    transform = {},

    body = {
      bodyType = "dynamic",
    },

    circleFixture = {},

    sprite = {
      image = "resources/images/spider/cephalothorax.png",
      transform = {0, 0, 0, 1 / 16, 1 / 16, 9, 9},
    },

    spider = {},
  },

  children = {
    {
      title = "Abdomen",

      components = {
        transform = {
          transform = {0, 0.75},
        },

        circleFixture = {
          radius = 0.5,
          sensor = true,
        },

        sprite = {
          image = "resources/images/spider/abdomen.png",
          transform = {0, 0, 0, 1 / 16, 1 / 16, 10, 10},
        },
      },
    },

    {
      prototype = "resources.leg",

      components = {
        transform = {
          transform = {0.31180110461345445, -0.20833883738235082, 0.19634954084936207},
        },
      },
    },

    {
      prototype = "resources.leg",

      components = {
        transform = {
          transform = {0.3677944801512114, -0.0731588707560481, 0.7853981633974483},
        },
      },
    },

    {
      prototype = "resources.leg",

      components = {
        transform = {
          transform = {0.3677944801512114, 0.0731588707560481, 2.356194490192345},
        },
      },
    },

    {
      prototype = "resources.leg",

      components = {
        transform = {
          transform = {0.31180110461345445, 0.20833883738235082, 2.945243112740431},
        },
      },
    },

    {
      prototype = "resources.leg",

      components = {
        transform = {
          transform = {-0.31180110461345445, 0.20833883738235082, -2.945243112740431},
        },
      },
    },

    {
      prototype = "resources.leg",

      components = {
        transform = {
          transform = {-0.3677944801512114, 0.0731588707560481, -2.356194490192345},
        },
      },
    },

    {
      prototype = "resources.leg",

      components = {
        transform = {
          transform = {-0.3677944801512114, -0.0731588707560481, -0.7853981633974483},
        },
      },
    },

    {
      prototype = "resources.leg",

      components = {
        transform = {
          transform = {-0.31180110461345445, -0.20833883738235082, -0.19634954084936207},
        },
      },
    },
  },
}
