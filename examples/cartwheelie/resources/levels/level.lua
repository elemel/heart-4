return {
  domains = {
    {
      domainType = "time",
      class = "heart.event.TimeDomain",
      fixedTimeStep = 1 / 60,
    },

    {
      domainType = "physics",
      class = "heart.physics.PhysicsDomain",
      gravityY = 15,
    },
  },

  componentManagers = {
    {
      componentType = "bone",
      class = "heart.rigging.BoneComponentManager",
    },

    {
      componentType = "parentConstraint",
      class = "heart.rigging.ParentConstraintComponentManager",
    },

    {
      componentType = "camera",
      class = "heart.CategoryComponentManager",
    },

    {
      componentType = "viewport",
      class = "heart.graphics.ViewportComponentManager",
    },

    {
      componentType = "body",
      class = "heart.physics.BodyComponentManager",
    },

    {
      componentType = "chainFixture",
      class = "heart.physics.ChainFixtureComponentManager",
    },

    {
      componentType = "circleFixture",
      class = "heart.physics.CircleFixtureComponentManager",
    },

    {
      componentType = "rectangleFixture",
      class = "heart.physics.RectangleFixtureComponentManager",
    },

    {
      componentType = "motorJoint",
      class = "heart.physics.MotorJointComponentManager",
    },

    {
      componentType = "revoluteJoint",
      class = "heart.physics.RevoluteJointComponentManager",
    },

    {
      componentType = "wheelJoint",
      class = "heart.physics.WheelJointComponentManager",
    },

    {
      componentType = "sprite",
      class = "heart.graphics.SpriteComponentManager",
    },

    {
      componentType = "minecart",
      class = "heart.CategoryComponentManager",
    },

    {
      componentType = "rider",
      class = "heart.CategoryComponentManager",
    },
  },

  systems = {
    draw = {
      {
        class = "heart.graphics.ViewportDrawSystem",
      },
    },

    drawWorld = {
      {
        class = "heart.graphics.SpriteDrawWorldSystem",
      },

      {
        class = "heart.physics.PhysicsDrawWorldSystem",
      },
    },

    fixedUpdate = {
      {
        class = "resources.scripts.RiderFixedUpdateSystem",
      },

      {
        class = "heart.physics.WorldFixedUpdateSystem",
      },

      {
        class = "heart.physics.BodyToBoneFixedUpdateSystem",
      },

      {
        class = "heart.rigging.ParentConstraintFixedUpdateSystem",
      },

      {
        class = "heart.graphics.BoneToSpriteFixedUpdateSystem",
      },
    },

    resize = {
      {
        class = "heart.graphics.ViewportResizeSystem",
      },
    },

    update = {
      {
        class = "heart.event.TimeUpdateSystem",
      },

      {
        class = "heart.graphics.SpriteUpdateSystem",
      },
    },
  },

  entities = {
    {
      transform = {0, 0, 0, 10},

      components = {
        bone = {},
        camera = {},
        viewport = {},
      },
    },

    {
      transform = {0, 2},

      components = {
        body = {},

        chainFixture = {
          points = {
            -5, 0.1,
            -4, -0.2,
            -3, 0.3,
            -2, 0.4,
            -1, -0.1,
            0, 0,
            1, -0.3,
            2, 0.2,
            3, 0.5,
            4, -0.4,
            5, -0.5,
          },
        },
      },
    },

    {
      prototype = "resources.entities.minecart",
      transform = {0, 0},
    },

    {
      prototype = "resources.entities.rider",
      transform = {0, -2},
    },
  },
}
