local set2 = heart.table.set2

local M = heart.class.newClass()

function M:init(engine, config)
  self.engine = assert(engine)

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
      attacking = "leapYear/resources/images/characters/demon/attackingDemon.png",
      climbing = "leapYear/resources/images/characters/demon/climbingDemon.png",
      dead = "leapYear/resources/images/characters/demon/deadDemon.png",
      idle = "leapYear/resources/images/characters/demon/idleDemon.png",
      jumping = "leapYear/resources/images/characters/demon/jumpingDemon.png",
      running = "leapYear/resources/images/characters/demon/runningDemon.png",
    },

    ghost = {
      attacking = "leapYear/resources/images/characters/ghost/attackingGhost.png",
      climbing = "leapYear/resources/images/characters/ghost/climbingGhost.png",
      dead = "leapYear/resources/images/characters/ghost/deadGhost.png",
      idle = "leapYear/resources/images/characters/ghost/idleGhost.png",
      jumping = "leapYear/resources/images/characters/ghost/jumpingGhost.png",
      running = "leapYear/resources/images/characters/ghost/runningGhost.png",
    },

    goblin = {
      attacking = "leapYear/resources/images/characters/goblin/attackingGoblin.png",
      climbing = "leapYear/resources/images/characters/goblin/climbingGoblin.png",
      dead = "leapYear/resources/images/characters/goblin/deadGoblin.png",
      idle = "leapYear/resources/images/characters/goblin/idleGoblin.png",
      jumping = "leapYear/resources/images/characters/goblin/jumpingGoblin.png",
      running = "leapYear/resources/images/characters/goblin/runningGoblin.png",
    },

  	man = {
      attacking = "leapYear/resources/images/characters/man/attackingMan.png",
      climbing = "leapYear/resources/images/characters/man/climbingMan.png",
      dead = "leapYear/resources/images/characters/man/deadMan.png",
  	  idle = "leapYear/resources/images/characters/man/idleMan.png",
  	  jumping = "leapYear/resources/images/characters/man/jumpingMan.png",
  	  running = "leapYear/resources/images/characters/man/runningMan.png",
  	},

    scorpion = {
      attacking = "leapYear/resources/images/characters/scorpion/attackingScorpion.png",
      dead = "leapYear/resources/images/characters/scorpion/deadScorpion.png",
      idle = "leapYear/resources/images/characters/scorpion/idleScorpion.png",
      jumping = "leapYear/resources/images/characters/scorpion/jumpingScorpion.png",
      running = "leapYear/resources/images/characters/scorpion/runningScorpion.png",
    },

    skeleton = {
      attacking = "leapYear/resources/images/characters/skeleton/attackingSkeleton.png",
      climbing = "leapYear/resources/images/characters/skeleton/climbingSkeleton.png",
      dead = "leapYear/resources/images/characters/skeleton/deadSkeleton.png",
      idle = "leapYear/resources/images/characters/skeleton/idleSkeleton.png",
      jumping = "leapYear/resources/images/characters/skeleton/jumpingSkeleton.png",
      running = "leapYear/resources/images/characters/skeleton/runningSkeleton.png",
    },

    spider = {
      attacking = "leapYear/resources/images/characters/spider/attackingSpider.png",
      dead = "leapYear/resources/images/characters/spider/deadSpider.png",
      idle = "leapYear/resources/images/characters/spider/idleSpider.png",
      jumping = "leapYear/resources/images/characters/spider/jumpingSpider.png",
      running = "leapYear/resources/images/characters/spider/runningSpider.png",
    },

    woman = {
      attacking = "leapYear/resources/images/characters/woman/attackingWoman.png",
      climbing = "leapYear/resources/images/characters/woman/climbingWoman.png",
      dead = "leapYear/resources/images/characters/woman/deadWoman.png",
      idle = "leapYear/resources/images/characters/woman/idleWoman.png",
      jumping = "leapYear/resources/images/characters/woman/jumpingWoman.png",
      running = "leapYear/resources/images/characters/woman/runningWoman.png",
    },

    zombie = {
      attacking = "leapYear/resources/images/characters/zombie/attackingZombie.png",
      climbing = "leapYear/resources/images/characters/zombie/climbingZombie.png",
      dead = "leapYear/resources/images/characters/zombie/deadZombie.png",
      idle = "leapYear/resources/images/characters/zombie/idleZombie.png",
      jumping = "leapYear/resources/images/characters/zombie/jumpingZombie.png",
      running = "leapYear/resources/images/characters/zombie/runningZombie.png",
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
