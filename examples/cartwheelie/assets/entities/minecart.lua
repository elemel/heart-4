return {
  components = {
    transform = {},
    bone = {},

    body = {
      bodyType = "dynamic",
    },

    rectangleFixture = {
      width = 1.5,
      height = 0.75,
      groupIndex = -2,
    },

    minecart = {},
  },

  children = {
    {
      components = {
        transform = {},

        rectangleFixture = {
          y = 0.325,
          width = 1.5,
          height = 0.1,
        },
      },
    },

    {
      components = {
        transform = {},

        rectangleFixture = {
          x = -0.7,
          width = 0.1,
          height = 0.75,
        },
      },
    },

    {
      components = {
        transform = {},

        rectangleFixture = {
          x = 0.7,
          width = 0.1,
          height = 0.75,
        },
      },
    },

    {
      transform = {0, 0, 0, 0.001, 0.001, 1000, 1000},

      components = {
        transform = {
          transform = {0, 0, 0, 0.001, 0.001, 1000, 1000},
        },

        bone = {},
        parentConstraint = {},

        mesh = {
          mesh = "assets/meshes/minecart.svg",
        },
      },
    },

    {
      transform = {-0.75, 0.375},

      components = {
        transform = {
          transform = {-0.75, 0.375},
        },

        bone = {},

        body = {
          bodyType = "dynamic",
        },

        circleFixture = {
          radius = 0.3,
          friction = 5,
          groupIndex = -2,
        },

        wheelJoint = {
          springFrequency = 10,
          springDampingRatio = 1,
          motorEnabled = true,
        },
      },

      children = {
        {
          transform = {0, 0, 0, 1 / 16, 1 / 16, 8, 8},

          components = {
            transform = {
              transform = {0, 0, 0, 1 / 16, 1 / 16, 8, 8},
            },

            bone = {},
            parentConstraint = {},

            sprite = {
              image = "assets/images/wheel.png",
            },
          },
        },
      },
    },

    {
      transform = {0.75, 0.375},

      components = {
        transform = {
          transform = {0.75, 0.375},
        },

        bone = {},

        body = {
          bodyType = "dynamic",
        },

        circleFixture = {
          radius = 0.3,
          friction = 5,
          groupIndex = -2,
        },

        wheelJoint = {
          springFrequency = 10,
          springDampingRatio = 1,
          motorEnabled = true,
        },
      },

      children = {
        {
          transform = {0, 0, 0, 1 / 16, 1 / 16, 8, 8},

          components = {
            transform = {
              transform = {0, 0, 0, 1 / 16, 1 / 16, 8, 8},
            },

            bone = {},
            parentConstraint = {},

            sprite = {
              image = "assets/images/wheel.png",
            },
          },
        },
      },
    },
  },
}
