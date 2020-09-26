return {
  title = "Leg",

  components = {
    transform = {},

    leg = {},
  },

  children = {
    {
      components = {
        transform = {},

        body = {
          bodyType = "dynamic",
          linearDamping = 0.25,
        },

        circleFixture = {
          radius = 0.125,
          sensor = true,
        },

        ropeJoint = {
          maxLength = 2,
        },
      },
    },
  },
}
