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

    {
      domainType = "level",
      class = "spider.LevelDomain",
      bounds = {{-10, -10}, {10, 10}},
    },
  },

  componentManagers = {
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
      componentType = "spider",
      class = "spider.SpiderComponentManager",
    },

    {
      componentType = "leg",
      class = "spider.LegComponentManager",
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
        player = {},

        transform = {
          transform = {0, -5},
        },

        body = {
          bodyType = "dynamic",
        },

        circleFixture = {},
        spider = {},
      },

      children = {
        {
          title = "Head",

          components = {
            transform = {
              transform = {0, -0.5},
            },

            circleFixture = {
              radius = 0.25,
            },
          },
        },

        {
          title = "Leg",

          components = {
            transform = {
              transform = {-0.4157348061512726, -0.2777851165098011},
            },

            leg = {},
          },
        },

        {
          title = "Leg",

          components = {
            transform = {
              transform = {-0.4903926402016152, -0.09754516100806412},
            },

            leg = {},
          },
        },

        {
          title = "Leg",

          components = {
            transform = {
              transform = {-0.4903926402016152, 0.09754516100806412},
            },

            leg = {},
          },
        },

        {
          title = "Leg",

          components = {
            transform = {
              transform = {-0.4157348061512726, 0.2777851165098011},
            },

            leg = {},
          },
        },

        {
          title = "Leg",

          components = {
            transform = {
              transform = {0.4157348061512726, -0.2777851165098011},
            },

            leg = {},
          },
        },

        {
          title = "Leg",

          components = {
            transform = {
              transform = {0.4903926402016152, -0.09754516100806412},
            },

            leg = {},
          },
        },

        {
          title = "Leg",

          components = {
            transform = {
              transform = {0.4903926402016152, 0.09754516100806412},
            },

            leg = {},
          },
        },

        {
          title = "Leg",

          components = {
            transform = {
              transform = {0.4157348061512726, 0.2777851165098011},
            },

            leg = {},
          },
        },
      },
    },
  },
}
