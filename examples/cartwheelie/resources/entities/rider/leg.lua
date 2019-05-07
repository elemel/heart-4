return {
  components = {
    body = {
      bodyType = "dynamic",
    },

    rectangleFixture = {
      groupIndex = -1,
      y = 0.175,
      width = 0.2,
      height = 0.4,
    },

    revoluteJoint = {
      limitsEnabled = true,
      lowerLimit = -0.75 * math.pi,
      upperLimit = 0.75 * math.pi,
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
          y = 0.175,
          width = 0.15,
          height = 0.4,
        },

        revoluteJoint = {
          limitsEnabled = true,
          lowerLimit = 0 * math.pi,
          upperLimit = 0.75 * math.pi,
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
              x = 0.075,
              y = 0.05,
              width = 0.3,
              height = 0.1,
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
