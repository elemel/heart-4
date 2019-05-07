return {
  components = {
    body = {
      bodyType = "dynamic",
    },

    rectangleFixture = {
      groupIndex = -1,
      y = 0.175,
      width = 0.15,
      height = 0.4,
    },

    revoluteJoint = {},
  },

  children = {
    {
      transform = {0, 0.35},

      components = {
        body = {
          bodyType = "dynamic",
        },

        rectangleFixture = {
          groupIndex = -1,
          y = 0.175,
          width = 0.1,
          height = 0.4,
        },

        revoluteJoint = {
          limitsEnabled = true,
          lowerLimit = -0.75 * math.pi,
          upperLimit = 0,
        },
      },

      children = {
        {
          transform = {0, 0.35},

          components = {
            body = {
              bodyType = "dynamic",
            },

            rectangleFixture = {
              groupIndex = -1,
              y = 0.05,
              width = 0.15,
              height = 0.15,
            },

            revoluteJoint = {
              limitsEnabled = true,
              lowerLimit = -0.25 * math.pi,
              upperLimit = 0.25 * math.pi,
            },
          },
        },
      },
    },
  },
}
