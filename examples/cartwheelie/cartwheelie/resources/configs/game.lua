return {
  domains = {
    {
      domainType = "timer",
      class = "heart.TimerDomain",
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
      componentType = "transform",
      class = "heart.animation.TransformComponentManager",
    },

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
      componentType = "meshInstance",
      class = "heart.graphics.MeshInstanceComponentManager",
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

    drawworld = {
      {
        class = "heart.graphics.SpriteDrawWorldSystem",
      },

      {
        class = "heart.graphics.MeshInstanceDrawWorldSystem",
      },
    },

    debugdraw = {
      -- {
      --   class = "heart.physics.FixtureDebugDrawSystem",
      -- },

      -- {
      --   class = "heart.physics.JointDebugDrawSystem",
      -- },

      -- {
      --   class = "heart.animation.BoneDebugDrawSystem",
      -- },
    },

    fixedupdate = {
      {
        class = "heart.animation.PreviousBoneTransformFixedUpdateSystem",
      },

      {
        class = "cartwheelie.RiderFixedUpdateSystem",
      },

      {
        class = "heart.physics.WorldFixedUpdateSystem",
      },

      {
        class = "heart.physics.BodyToBoneFixedUpdateSystem",
      },

      {
        class = "cartwheelie.CameraFromRiderFixedUpdateSystem",
      },

      {
        class = "heart.animation.ParentConstraintFixedUpdateSystem",
      },
    },

    resize = {
      {
        class = "heart.graphics.ViewportResizeSystem",
      },
    },

    update = {
      {
        class = "heart.TimerUpdateSystem",
      },

      {
        class = "heart.graphics.SpriteFromBoneUpdateSystem",
      },

      {
        class = "heart.graphics.MeshInstanceFromBoneUpdateSystem",
      },

      {
        class = "heart.graphics.CameraFromBoneUpdateSystem",
      },
    },
  },

  entities = {
    {
      transform = {0, 0, 0, 5},

      components = {
        transform = {
          transform = {0, 0, 0, 5},
        },

        bone = {},
        camera = {},
        viewport = {},
      },
    },

    {
      transform = {0, 0, 0, 0.001, 0.001, 8000, 8000, z = -1},

      components = {
        transform = {
          transform = {0, 0, 0, 0.001, 0.001, 8000, 8000, z = -1},
        },

        meshInstance = {
          mesh = "cartwheelie/resources/meshes/background.svg",
        },
      },
    },

    {
      transform = {0, 2},

      components = {
        transform = {
          transform = {0, 2},
        },

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
      prototype = "cartwheelie.resources.configs.entities.minecart",
      transform = {-4, 0},

      components = {
        transform = {
          transform = {-4, 0},
        },
      },
    },

    {
      prototype = "cartwheelie.resources.configs.entities.rider",
      transform = {-4, -2},

      components = {
        transform = {
          transform = {-4, -2},
        },
      },
    },
  },
}
