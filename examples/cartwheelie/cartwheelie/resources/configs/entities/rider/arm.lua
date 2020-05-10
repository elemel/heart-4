return {
  components = {
    transform = {},

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

    revoluteJoint = {},
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
          mesh = "cartwheelie/resources/meshes/rider/upper-arm.svg",
        },
      },
    },

    {
      transform = {0, 0.35},

      components = {
        transform = {
          transform = {0, 0.35},
        },

        bone = {
          flat = true,
        },

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
          lowerLimit = -0.875 * math.pi,
          upperLimit = 0,
        },
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
              mesh = "cartwheelie/resources/meshes/rider/lower-arm.svg",
            },
          },
        },

        {
          transform = {0, 0.35},

          components = {
            transform = {
              transform = {0, 0.35},
            },

            bone = {
              flat = true,
            },

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
                  mesh = "cartwheelie/resources/meshes/rider/hand.svg",
                },
              },
            },
          },
        },
      },
    },
  },
}
