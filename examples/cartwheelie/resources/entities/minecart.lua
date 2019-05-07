return {
  components = {
    body = {
      bodyType = "dynamic",
    },

    rectangleFixture = {
      width = 1.5,
      height = 0.75,
    },

    minecart = {},
  },

  children = {
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
          springFrequency = 4,
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
          springFrequency = 4,
          springDampingRatio = 1,
          motorEnabled = true,
        },
      },
    },
  },
}
