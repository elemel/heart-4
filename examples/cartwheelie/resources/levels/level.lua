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
      class = "heart.animation.BoneComponentManager",
    },

    {
      componentType = "parentConstraint",
      class = "heart.animation.ParentConstraintComponentManager",
    },

    {
      componentType = "camera",
      class = "heart.graphics.CameraComponentManager",
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
      componentType = "mesh",
      class = "heart.graphics.MeshComponentManager",
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
        class = "heart.graphics.MeshDrawWorldSystem",
      },
    },

    debugDraw = {
      {
        class = "heart.physics.PhysicsDebugDrawSystem",
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
        class = "resources.scripts.RiderToCameraFixedUpdateSystem",
      },

      {
        class = "heart.animation.ParentConstraintFixedUpdateSystem",
      },

      {
        class = "heart.graphics.BoneToSpriteFixedUpdateSystem",
      },

      {
        class = "heart.graphics.BoneToMeshFixedUpdateSystem",
      },

      {
        class = "heart.graphics.BoneToCameraFixedUpdateSystem",
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

      {
        class = "heart.graphics.MeshUpdateSystem",
      },

      {
        class = "heart.graphics.CameraUpdateSystem",
      },
    },
  },

  entities = {
    {
      transform = {0, 0, 0, 5},

      components = {
        bone = {},
        camera = {},
        viewport = {},
      },
    },

    {
      transform = {0, 0, 0, 0.001, 0.001, 8000, 8000, z = -1},

      components = {
        mesh = {
          mesh = "resources/meshes/background.svg",
        },
      },
    },

    {
      transform = {0, 2},

      components = {
        body = {},

        chainFixture = {
          points = {
            -8, 0.2,
            -7, 0.7,
            -6, 1.2,
            -5, 1.5,
            -4, 1.4,
            -3, 1,
            -2, 0.55,
            -1.5, 0.35,
            -1, 0.25,
            -0.5, 0.2,
            0, 0.3,
            0.5, 0.4,
            1, 0.55,
            2, 0.8,
            3, 1,
            4, 1.2,
            5, 1.1,
            6, 0.8,
            7, 0.3,
            8, -0.3,
          },
        },
      },
    },

    {
      prototype = "resources.entities.minecart",
      transform = {-4, 0},
    },

    {
      prototype = "resources.entities.rider",
      transform = {-4, -2},
    },
  },
}
