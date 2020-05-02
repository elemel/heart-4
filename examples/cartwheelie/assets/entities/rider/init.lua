return {
  components = {
    transform = {},
    bone = {},

    body = {
      bodyType = "dynamic",
    },

    rectangleFixture = {
      groupIndex = -1,
      width = 0.4,
      height = 0.8,
    },

    rider = {},
  },

  children = {
    {
      transform = {0, 0, 0, 0.001, 0.001, 500, 500},

      components = {
        transform = {
          transform = {0, 0, 0, 0.001, 0.001, 500, 500},
        },

        bone = {},
        parentConstraint = {},

        meshInstance = {
          mesh = "assets/meshes/rider/torso.svg",
        },
      },
    },

    {
      transform = {0, -0.4, z = 0.01},
      prototype = "assets.entities.rider.head",

      components = {
        transform = {
          transform = {0, -0.4, z = 0.01},
        },
      },
    },

    {
      transform = {-0.1, -0.35, z = 0.2},
      prototype = "assets.entities.rider.arm",

      components = {
        transform = {
          transform = {-0.1, -0.35, z = 0.2},
        },
      },
    },

    {
      transform = {0.1, -0.35, z = -0.2},
      prototype = "assets.entities.rider.arm",

      components = {
        transform = {
          transform = {0.1, -0.35, z = -0.2},
        },
      },
    },

    {
      transform = {-0.1, 0.35, z = 0.15},
      prototype = "assets.entities.rider.leg",

      components = {
        transform = {
          transform = {-0.1, 0.35, z = 0.15},
        },
      },
    },

    {
      transform = {0.1, 0.35, z = -0.15},
      prototype = "assets.entities.rider.leg",

      components = {
        transform = {
          transform = {0.1, 0.35, z = -0.15},
        },
      },
    },
  },
}
