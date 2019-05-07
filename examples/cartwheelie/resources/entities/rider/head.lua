return {
  components = {
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
}
