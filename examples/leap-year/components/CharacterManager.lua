local set2 = heart.table.set2

local M = heart.class.newClass()

function M:init(game, config)
  self.game = assert(game)

  self.directionXs = {}
  self.characterTypes = {}
  self.animationTimes = {}

  self.oldInputXs = {}
  self.oldInputYs = {}

  self.oldRunInputs = {}
  self.oldJumpInputs = {}

  self.inputXs = {}
  self.inputYs = {}

  self.runInputs = {}
  self.jumpInputs = {}

  self.skins = {
    demon = {
      attacking = "assets/images/characters/demon/attackingDemon.png",
      climbing = "assets/images/characters/demon/climbingDemon.png",
      dead = "assets/images/characters/demon/deadDemon.png",
      idle = "assets/images/characters/demon/idleDemon.png",
      jumping = "assets/images/characters/demon/jumpingDemon.png",
      running = "assets/images/characters/demon/runningDemon.png",
    },

    ghost = {
      attacking = "assets/images/characters/ghost/attackingGhost.png",
      climbing = "assets/images/characters/ghost/climbingGhost.png",
      dead = "assets/images/characters/ghost/deadGhost.png",
      idle = "assets/images/characters/ghost/idleGhost.png",
      jumping = "assets/images/characters/ghost/jumpingGhost.png",
      running = "assets/images/characters/ghost/runningGhost.png",
    },

    goblin = {
      attacking = "assets/images/characters/goblin/attackingGoblin.png",
      climbing = "assets/images/characters/goblin/climbingGoblin.png",
      dead = "assets/images/characters/goblin/deadGoblin.png",
      idle = "assets/images/characters/goblin/idleGoblin.png",
      jumping = "assets/images/characters/goblin/jumpingGoblin.png",
      running = "assets/images/characters/goblin/runningGoblin.png",
    },

  	man = {
      attacking = "assets/images/characters/man/attackingMan.png",
      climbing = "assets/images/characters/man/climbingMan.png",
      dead = "assets/images/characters/man/deadMan.png",
  	  idle = "assets/images/characters/man/idleMan.png",
  	  jumping = "assets/images/characters/man/jumpingMan.png",
  	  running = "assets/images/characters/man/runningMan.png",
  	},

    scorpion = {
      attacking = "assets/images/characters/scorpion/attackingScorpion.png",
      dead = "assets/images/characters/scorpion/deadScorpion.png",
      idle = "assets/images/characters/scorpion/idleScorpion.png",
      jumping = "assets/images/characters/scorpion/jumpingScorpion.png",
      running = "assets/images/characters/scorpion/runningScorpion.png",
    },

    skeleton = {
      attacking = "assets/images/characters/skeleton/attackingSkeleton.png",
      climbing = "assets/images/characters/skeleton/climbingSkeleton.png",
      dead = "assets/images/characters/skeleton/deadSkeleton.png",
      idle = "assets/images/characters/skeleton/idleSkeleton.png",
      jumping = "assets/images/characters/skeleton/jumpingSkeleton.png",
      running = "assets/images/characters/skeleton/runningSkeleton.png",
    },

    spider = {
      attacking = "assets/images/characters/spider/attackingSpider.png",
      dead = "assets/images/characters/spider/deadSpider.png",
      idle = "assets/images/characters/spider/idleSpider.png",
      jumping = "assets/images/characters/spider/jumpingSpider.png",
      running = "assets/images/characters/spider/runningSpider.png",
    },

    woman = {
      attacking = "assets/images/characters/woman/attackingWoman.png",
      climbing = "assets/images/characters/woman/climbingWoman.png",
      dead = "assets/images/characters/woman/deadWoman.png",
      idle = "assets/images/characters/woman/idleWoman.png",
      jumping = "assets/images/characters/woman/jumpingWoman.png",
      running = "assets/images/characters/woman/runningWoman.png",
    },

    zombie = {
      attacking = "assets/images/characters/zombie/attackingZombie.png",
      climbing = "assets/images/characters/zombie/climbingZombie.png",
      dead = "assets/images/characters/zombie/deadZombie.png",
      idle = "assets/images/characters/zombie/idleZombie.png",
      jumping = "assets/images/characters/zombie/jumpingZombie.png",
      running = "assets/images/characters/zombie/runningZombie.png",
    },
  }

  self.crouchingAcceleration = 8
  self.crouchingJumpSpeed = 6

  self.fallingAcceleration = 34

  self.glidingSpeed = 3
  self.glidingAcceleration = 8

  self.slidingAcceleration = 4
  self.slidingJumpSpeed = 10

  self.sneakingAcceleration = 8
  self.sneakingSpeed = 3
  self.sneakingJumpSpeed = 10

  self.standingAcceleration = 12
  self.standingJumpSpeed = 10

  self.runningAcceleration = 34
  self.runningJumpSpeed = 16
  self.runningSpeed = 8

  self.walkingJumpSpeed = 13
  self.walkingSpeed = 5
  self.walkingAcceleration = 21

  self.wallSlidingJumpSpeedX = 5
  self.wallSlidingJumpSpeedY = 13
  self.wallSlidingAcceleration = 32
  self.wallSlidingSpeed = 5
end

function M:createComponent(id, config)
  self.characterTypes[id] = assert(config.characterType)
  self.directionXs[id] = config.directionX or 1
  self.animationTimes[id] = config.animationTime or 0

  self.oldInputXs[id] = 0
  self.oldInputYs[id] = 0

  self.oldRunInputs[id] = false
  self.oldJumpInputs[id] = false

  self.inputXs[id] = 0
  self.inputYs[id] = 0

  self.runInputs[id] = false
  self.jumpInputs[id] = false
end

function M:destroyComponent(id)
  self.characterTypes[id] = nil
  self.directionXs[id] = nil
  self.animationTimes[id] = nil

  self.oldInputXs[id] = nil
  self.oldInputYs[id] = nil

  self.oldRunInputs[id] = nil
  self.oldJumpInputs[id] = nil

  self.inputXs[id] = nil
  self.inputYs[id] = nil

  self.runInputs[id] = nil
  self.jumpInputs[id] = nil
end

return M
