return {
  prototype = "resources.levels.level",

  entities = {
    {
      title = "Camera",

      components = {
        transform = {},
        viewport = {},

        camera = {
          transform = {0, 0, 0, 16},
        },
      },
    },

    {
      components = {
        transform = {
          transform = {-1, -1},
        },

        body = {},

        polygonFixture = {
          transform = {0, 0, 0, 4, 1},
        },
      },
    },

    {
      components = {
        transform = {
          transform = {-3, -1, 0.125 * math.pi},
        },

        body = {},

        polygonFixture = {
          transform = {0, 0, 0, 1, 4},
        },
      },
    },

    {
      components = {
        transform = {
          transform = {2, 4, -0.25 * math.pi},
        },

        body = {},

        polygonFixture = {
          transform = {0, 0, 0, 4, 1},
        },
      },
    },

    {
      components = {
        transform = {},
        body = {},
      },

      children = {
        {
          components = {
            transform = {
              transform = {5, -4, 1.25 * math.pi},
            },

            body = {
              bodyType = "dynamic",
            },

            polygonFixture = {
              transform = {0, 0, 0, 4, 1},
            },

            revoluteJoint = {
              motorEnabled = true,
              maxMotorTorque = 10,
            },
          },
        },
      },
    },

    {
      components = {
        transform = {
          transform = {10, 0},
        },

        body = {},

        polygonFixture = {
          transform = {0, 0, 0, 1, 8},
        },
      },
    },

    {
      components = {
        transform = {
          transform = {16, 0},
        },

        body = {},

        polygonFixture = {
          transform = {0, 0, 0, 1, 8},
        },
      },
    },

    {
      prototype = "resources.spider",

      components = {
        transform = {
          transform = {0, -5},
        },
      },
    },
  },
}
