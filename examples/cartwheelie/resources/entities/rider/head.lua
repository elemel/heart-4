return {
  components = {
    bone = {
      flat = true,
    },

    body = {
      bodyType = "dynamic",
    },

    circleFixture = {
      groupIndex = -1,
      y = -0.15,
      radius = 0.15,
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
          mesh = "resources/meshes/rider/head.svg",
        },
      },
    },
  },
}
