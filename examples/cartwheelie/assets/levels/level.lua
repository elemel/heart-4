return {
  domains = {
    {
      domainType = "timer",
      class = "heart.timer.domains.TimerDomain",
      fixedTimeStep = 1 / 60,
    },

    {
      domainType = "physics",
      class = "heart.physics.domains.PhysicsDomain",
      gravityY = 15,
    },
  },

  componentManagers = {
    {
      componentType = "transform",
      class = "heart.animation.components.TransformManager",
    },

    {
      componentType = "bone",
      class = "heart.animation.components.BoneManager",
    },

    {
      componentType = "parentConstraint",
      class = "heart.animation.components.ParentConstraintManager",
    },

    {
      componentType = "camera",
      class = "heart.graphics.components.CameraManager",
    },

    {
      componentType = "viewport",
      class = "heart.graphics.components.ViewportManager",
    },

    {
      componentType = "body",
      class = "heart.physics.components.BodyManager",
    },

    {
      componentType = "chainFixture",
      class = "heart.physics.components.ChainFixtureManager",
    },

    {
      componentType = "circleFixture",
      class = "heart.physics.components.CircleFixtureManager",
    },

    {
      componentType = "rectangleFixture",
      class = "heart.physics.components.RectangleFixtureManager",
    },

    {
      componentType = "motorJoint",
      class = "heart.physics.components.MotorJointManager",
    },

    {
      componentType = "revoluteJoint",
      class = "heart.physics.components.RevoluteJointManager",
    },

    {
      componentType = "wheelJoint",
      class = "heart.physics.components.WheelJointManager",
    },

    {
      componentType = "sprite",
      class = "heart.graphics.components.SpriteManager",
    },

    {
      componentType = "meshInstance",
      class = "heart.graphics.components.MeshInstanceManager",
    },

    {
      componentType = "minecart",
      class = "heart.taxonomy.components.CategoryManager",
    },

    {
      componentType = "rider",
      class = "heart.taxonomy.components.CategoryManager",
    },
  },

  systems = {
    draw = {
      {
        class = "heart.graphics.systems.draw.DrawViewportSystem",
      },
    },

    drawworld = {
      {
        class = "heart.graphics.systems.drawworld.DrawSpriteSystem",
      },

      {
        class = "heart.graphics.systems.drawworld.DrawMeshInstanceSystem",
      },
    },

    debugdraw = {
      -- {
      --   class = "heart.physics.systems.debugdraw.DebugDrawFixtures",
      -- },

      -- {
      --   class = "heart.physics.systems.debugdraw.DebugDrawJoints",
      -- },

      -- {
      --   class = "heart.animation.systems.debugdraw.DebugDrawBones",
      -- },
    },

    fixedupdate = {
      {
        class = "heart.animation.systems.fixedupdate.UpdatePreviousBoneTransformSystem",
      },

      {
        class = "cartwheelie.systems.fixedupdate.UpdateRiderSystem",
      },

      {
        class = "heart.physics.systems.fixedupdate.UpdateWorldSystem",
      },

      {
        class = "heart.physics.systems.fixedupdate.UpdateBoneFromBodySystem",
      },

      {
        class = "cartwheelie.systems.fixedupdate.UpdateCameraFromRiderSystem",
      },

      {
        class = "heart.animation.systems.fixedupdate.UpdateParentConstraintSystem",
      },
    },

    resize = {
      {
        class = "heart.graphics.systems.resize.ResizeViewportSystem",
      },
    },

    update = {
      {
        class = "heart.timer.systems.update.UpdateTimerSystem",
      },

      {
        class = "heart.graphics.systems.update.UpdateSpriteFromBoneSystem",
      },

      {
        class = "heart.graphics.systems.update.UpdateMeshInstanceFromBoneSystem",
      },

      {
        class = "heart.graphics.systems.update.UpdateCameraFromBoneSystem",
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
          mesh = "assets/meshes/background.svg",
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
      prototype = "assets.entities.minecart",
      transform = {-4, 0},

      components = {
        transform = {
          transform = {-4, 0},
        },
      },
    },

    {
      prototype = "assets.entities.rider",
      transform = {-4, -2},

      components = {
        transform = {
          transform = {-4, -2},
        },
      },
    },
  },
}
