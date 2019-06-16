return {
  components = {
    bone = {},

    body = {
      bodyType = "dynamic",
    },

    rectangleFixture = {
      groupIndex = -1,
      width = 0.4,
      height = 0.8,
    },

    rider = {},
  },

  children = {
    {
      transform = {0, 0, 0, 0.001, 0.001, 500, 500},

      components = {
        bone = {},
        parentConstraint = {},

        mesh = {
          mesh = "resources/meshes/rider/torso.svg",
        },
      },
    },

    {
      transform = {0, -0.4, z = 0.01},
      prototype = "resources.entities.rider.head",
    },

    {
      transform = {-0.1, -0.35, z = 0.2},
      prototype = "resources.entities.rider.arm",
    },

    {
      transform = {0.1, -0.35, z = -0.2},
      prototype = "resources.entities.rider.arm",
    },

    {
      transform = {-0.1, 0.35, z = 0.15},
      prototype = "resources.entities.rider.leg",
    },

    {
      transform = {0.1, 0.35, z = -0.15},
      prototype = "resources.entities.rider.leg",
    },
  },
}
