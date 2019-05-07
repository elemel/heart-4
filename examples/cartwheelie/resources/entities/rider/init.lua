return {
  components = {
    body = {
      bodyType = "dynamic",
    },

    rectangleFixture = {
      groupIndex = -1,
      width = 0.4,
      height = 0.8,
    },
  },

  children = {
    {
      transform = {0, -0.4},
      prototype = "resources.entities.rider.head",
    },

    {
      transform = {-0.1, -0.35},
      prototype = "resources.entities.rider.arm",
    },

    {
      transform = {0.1, -0.35},
      prototype = "resources.entities.rider.arm",
    },

    {
      transform = {-0.1, 0.35},
      prototype = "resources.entities.rider.leg",
    },

    {
      transform = {0.1, 0.35},
      prototype = "resources.entities.rider.leg",
    },
  },
}
