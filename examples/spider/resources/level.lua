return {
  domains = {
    {
      domainType = "timer",
      class = "heart.TimerDomain",
    },

    {
      domainType = "physics",
      class = "heart.physics.PhysicsDomain",
      gravity = {0, 10},
    },
  },

  componentManagers = {
    {
      componentType = "spider",
      class = "heart.CategoryComponentManager",
    },

    {
      componentType = "leg",
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
  },

  systems = {
    debugdraw = {
      {
        class = "heart.physics.FixtureDebugDrawSystem",
      },

      {
        class = "heart.physics.JointDebugDrawSystem",
      },

      {
        class = "spider.SpiderDebugDrawSystem",
      },
    },

    draw = {
      {
        class = "heart.graphics.ViewportDrawSystem",
      },
    },

    fixedupdate = {
      {
        class = "spider.SpiderFixedUpdateSystem",
      },

      {
        class = "heart.physics.WorldFixedUpdateSystem",
      },

      {
        class = "heart.physics.DynamicBodyFixedUpdateSystem",
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
          transform = {0, 0, 0, 10},
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
          transform = {0, 0, 0, 5, 1},
        },
      },
    },

    {
      components = {
        transform = {
          transform = {-3, -1, 0.1 * math.pi},
        },

        body = {},

        polygonFixture = {
          transform = {0, 0, 0, 1, 5},
        },
      },
    },

    {
      components = {
        transform = {
          transform = {2, 2, -0.2 * math.pi},
        },

        body = {},

        polygonFixture = {
          transform = {0, 0, 0, 5, 1},
        },
      },
    },

    {
      title = "Spider",

      components = {
        spider = {},

        transform = {
          transform = {0, -5},
        },

        body = {
          bodyType = "dynamic",
          fixedRotation = true,
        },

        circleFixture = {},
      },

      children = {
        {
          components = {
            transform = {},

            circleFixture = {
              density = 0,
              radius = 2,
              sensor = true,
            },
          },
        },
      },
    },
  },
}
