return {
  components = {
    bone = {},

    body = {
      bodyType = "dynamic",
    },

    rectangleFixture = {
      width = 1.5,
      height = 0.75,
      sensor = true,
    },

    minecart = {},
  },

  children = {
    {
      components = {
        rectangleFixture = {
          y = 0.325,
          width = 1.5,
          height = 0.1,
        },
      },
    },

    {
      components = {
        rectangleFixture = {
          x = -0.7,
          width = 0.1,
          height = 0.75,
        },
      },
    },

    {
      components = {
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
        bone = {},
        parentConstraint = {},

        mesh = {
          mesh = "resources/meshes/minecart.svg",
        },
      },
    },

    {
      transform = {-0.75, 0.375},

      components = {
        bone = {},

        body = {
          bodyType = "dynamic",
        },

        circleFixture = {
          radius = 0.3,
          friction = 5,
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
            bone = {},
            parentConstraint = {},

            sprite = {
              image = "resources/images/wheel.png",
            },
          },
        },
      },
    },

    {
      transform = {0.75, 0.375},

      components = {
        bone = {},

        body = {
          bodyType = "dynamic",
        },

        circleFixture = {
          radius = 0.3,
          friction = 5,
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
            bone = {},
            parentConstraint = {},

            sprite = {
              image = "resources/images/wheel.png",
            },
          },
        },
      },
    },
  },
}
