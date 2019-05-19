return {
  components = {
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
      transform = {-0.75, 0.375},

      components = {
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
    },

    {
      transform = {0.75, 0.375},

      components = {
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

        sprite = {
          image = "resources/images/wheel.png",
        },
      },
    },
  },
}
