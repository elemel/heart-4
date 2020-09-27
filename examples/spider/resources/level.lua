return {
  domains = {
    {
      domainType = "timer",
      class = "heart.TimerDomain",
    },

    {
      domainType = "physics",
      class = "heart.physics.PhysicsDomain",
      gravity = {0, 32},
    },

    {
      domainType = "level",
      class = "spider.LevelDomain",
      bounds = {{-15, -10}, {25, 10}},
    },
  },

  componentManagers = {
    {
      componentType = "leg",
      class = "heart.CategoryComponentManager",
    },

    {
      componentType = "player",
      class = "heart.CategoryComponentManager",
    },

    {
      componentType = "transform",
      class = "heart.animation.TransformComponentManager",
    },

    {
      componentType = "viewport",
      class = "heart.graphics.ViewportComponentManager",
    },

    {
      componentType = "camera",
      class = "heart.graphics.CameraComponentManager",
    },

    {
      componentType = "body",
      class = "heart.physics.BodyComponentManager",
    },

    {
      componentType = "circleFixture",
      class = "heart.physics.CircleFixtureComponentManager",
    },

    {
      componentType = "polygonFixture",
      class = "heart.physics.PolygonFixtureComponentManager",
    },

    {
      componentType = "distanceJoint",
      class = "heart.physics.DistanceJointComponentManager",
    },

    {
      componentType = "revoluteJoint",
      class = "heart.physics.RevoluteJointComponentManager",
    },

    {
      componentType = "ropeJoint",
      class = "heart.physics.RopeJointComponentManager",
    },

    {
      componentType = "spider",
      class = "spider.SpiderComponentManager",
    },

    {
      componentType = "foot",
      class = "spider.FootComponentManager",
    },
  },

  systems = {
    debugdraw = {
      -- {
      --   class = "heart.physics.FixtureDebugDrawSystem",
      -- },

      -- {
      --   class = "heart.physics.JointDebugDrawSystem",
      -- },

      -- {
      --   class = "spider.SpiderDebugDrawSystem",
      -- },

      -- {
      --   class = "spider.LevelDebugDrawSystem",
      -- },
    },

    draw = {
      {
        class = "heart.graphics.ViewportDrawSystem",
      },
    },

    drawworld = {
      {
        class = "spider.DrawWorldSystem",
      },
    },

    fixedupdate = {
      {
        class = "heart.animation.TransformFixedUpdateSystem",
      },

      {
        class = "spider.InputFixedUpdateSystem",
      },

      {
        class = "spider.SpiderFixedUpdateSystem",
      },

      {
        class = "heart.physics.WorldFixedUpdateSystem",
      },

      {
        class = "heart.physics.DynamicBodyFixedUpdateSystem",
      },

      {
        class = "spider.FootAnimationFixedUpdateSystem",
      },

      {
        class = "spider.CameraFixedUpdateSystem",
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
        class = "heart.graphics.CameraUpdateSystem",
      },
    },
  },

  entities = {
    {
      title = "Camera",

      components = {
        transform = {},
        viewport = {},

        camera = {
          transform = {0, 0, 0, 16},
        },
      },
    },

    {
      components = {
        transform = {
          transform = {-1, -1},
        },

        body = {},

        polygonFixture = {
          transform = {0, 0, 0, 4, 1},
        },
      },
    },

    {
      components = {
        transform = {
          transform = {-3, -1, 0.125 * math.pi},
        },

        body = {},

        polygonFixture = {
          transform = {0, 0, 0, 1, 4},
        },
      },
    },

    {
      components = {
        transform = {
          transform = {2, 4, -0.25 * math.pi},
        },

        body = {},

        polygonFixture = {
          transform = {0, 0, 0, 4, 1},
        },
      },
    },

    {
      components = {
        transform = {},
        body = {},
      },

      children = {
        {
          components = {
            transform = {
              transform = {5, -4, 1.25 * math.pi},
            },

            body = {
              bodyType = "dynamic",
            },

            polygonFixture = {
              transform = {0, 0, 0, 4, 1},
            },

            revoluteJoint = {
              motorEnabled = true,
              maxMotorTorque = 10,
            },
          },
        },
      },
    },

    {
      components = {
        transform = {
          transform = {10, 0},
        },

        body = {},

        polygonFixture = {
          transform = {0, 0, 0, 1, 8},
        },
      },
    },

    {
      components = {
        transform = {
          transform = {16, 0},
        },

        body = {},

        polygonFixture = {
          transform = {0, 0, 0, 1, 8},
        },
      },
    },

    {
      prototype = "resources.spider",

      components = {
        transform = {
          transform = {0, -5},
        },
      },
    },
  },
}
