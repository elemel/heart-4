return {
  components = {
    bone = {
      flat = true,
    },

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
      lowerLimit = -0.875 * math.pi,
      upperLimit = 0.875 * math.pi,
    },
  },

  children = {
    {
      transform = {0, 0, 0, 0.001, 0.001, 500, 500},

      components = {
        bone = {},
        parentConstraint = {},

        mesh = {
          mesh = "resources/meshes/rider/upper-leg.svg",
        },
      },
    },

    {
      transform = {0, 0.35},

      components = {
        bone = {
          flat = true,
        },

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
          upperLimit = 0.875 * math.pi,
        },
      },

      children = {
        {
          transform = {0, 0, 0, 0.001, 0.001, 500, 500},

          components = {
            bone = {},
            parentConstraint = {},

            mesh = {
              mesh = "resources/meshes/rider/lower-leg.svg",
            },
          },
        },

        {
          transform = {0, 0.35},

          components = {
            bone = {
              flat = true,
            },

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

          children = {
            {
              transform = {0, 0, 0, 0.001, 0.001, 500, 500},

              components = {
                bone = {},
                parentConstraint = {},

                mesh = {
                  mesh = "resources/meshes/rider/foot.svg",
                },
              },
            },
          },
        },
      },
    },
  },
}
