return {
  domains = {
    {
      domainType = "timer",
      class = "heart.timer.domains.Timer",
      fixedTimeStep = 1 / 60,
    },

    {
      domainType = "physics",
      class = "heart.physics.domains.Physics",
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
      componentType = "mesh",
      class = "heart.graphics.components.MeshManager",
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
        class = "heart.graphics.systems.draw.DrawViewports",
      },
    },

    drawWorld = {
      {
        class = "heart.graphics.systems.drawWorld.DrawWorldSprites",
      },

      {
        class = "heart.graphics.systems.drawWorld.DrawWorldMeshes",
      },
    },

    debugDraw = {
      {
        class = "heart.physics.systems.debugDraw.DebugDrawPhysics",
      },
    },

    fixedUpdate = {
      {
        class = "heart.animation.systems.fixedUpdate.FixedUpdateBones",
      },

      {
        class = "assets.scripts.systems.fixedUpdate.FixedUpdateRiders",
      },

      {
        class = "heart.physics.systems.fixedUpdate.FixedUpdateWorld",
      },

      {
        class = "heart.physics.systems.fixedUpdate.FixedUpdateBonesFromBodies",
      },

      {
        class = "assets.scripts.systems.fixedUpdate.FixedUpdateCamerasFromRiders",
      },

      {
        class = "heart.animation.systems.fixedUpdate.FixedUpdateParentConstraints",
      },
    },

    resize = {
      {
        class = "heart.graphics.systems.resize.ResizeViewports",
      },
    },

    update = {
      {
        class = "heart.timer.systems.update.UpdateTimer",
      },

      {
        class = "heart.graphics.systems.update.UpdateSpritesFromBones",
      },

      {
        class = "heart.graphics.systems.update.UpdateMeshesFromBones",
      },

      {
        class = "heart.graphics.systems.update.UpdateCamerasFromBones",
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

        mesh = {
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