local set2 = heart.table.set2

local CharacterComponentManager = heart.class.newClass()

function CharacterComponentManager:init(game, config)
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
      attacking = "resources/images/characters/demon/attackingDemon.png",
      climbing = "resources/images/characters/demon/climbingDemon.png",
      dead = "resources/images/characters/demon/deadDemon.png",
      idle = "resources/images/characters/demon/idleDemon.png",
      jumping = "resources/images/characters/demon/jumpingDemon.png",
      running = "resources/images/characters/demon/runningDemon.png",
    },

    ghost = {
      attacking = "resources/images/characters/ghost/attackingGhost.png",
      climbing = "resources/images/characters/ghost/climbingGhost.png",
      dead = "resources/images/characters/ghost/deadGhost.png",
      idle = "resources/images/characters/ghost/idleGhost.png",
      jumping = "resources/images/characters/ghost/jumpingGhost.png",
      running = "resources/images/characters/ghost/runningGhost.png",
    },

    goblin = {
      attacking = "resources/images/characters/goblin/attackingGoblin.png",
      climbing = "resources/images/characters/goblin/climbingGoblin.png",
      dead = "resources/images/characters/goblin/deadGoblin.png",
      idle = "resources/images/characters/goblin/idleGoblin.png",
      jumping = "resources/images/characters/goblin/jumpingGoblin.png",
      running = "resources/images/characters/goblin/runningGoblin.png",
    },

  	man = {
      attacking = "resources/images/characters/man/attackingMan.png",
      climbing = "resources/images/characters/man/climbingMan.png",
      dead = "resources/images/characters/man/deadMan.png",
  	  idle = "resources/images/characters/man/idleMan.png",
  	  jumping = "resources/images/characters/man/jumpingMan.png",
  	  running = "resources/images/characters/man/runningMan.png",
  	},

    scorpion = {
      attacking = "resources/images/characters/scorpion/attackingScorpion.png",
      dead = "resources/images/characters/scorpion/deadScorpion.png",
      idle = "resources/images/characters/scorpion/idleScorpion.png",
      jumping = "resources/images/characters/scorpion/jumpingScorpion.png",
      running = "resources/images/characters/scorpion/runningScorpion.png",
    },

    skeleton = {
      attacking = "resources/images/characters/skeleton/attackingSkeleton.png",
      climbing = "resources/images/characters/skeleton/climbingSkeleton.png",
      dead = "resources/images/characters/skeleton/deadSkeleton.png",
      idle = "resources/images/characters/skeleton/idleSkeleton.png",
      jumping = "resources/images/characters/skeleton/jumpingSkeleton.png",
      running = "resources/images/characters/skeleton/runningSkeleton.png",
    },

    spider = {
      attacking = "resources/images/characters/spider/attackingSpider.png",
      dead = "resources/images/characters/spider/deadSpider.png",
      idle = "resources/images/characters/spider/idleSpider.png",
      jumping = "resources/images/characters/spider/jumpingSpider.png",
      running = "resources/images/characters/spider/runningSpider.png",
    },

    woman = {
      attacking = "resources/images/characters/woman/attackingWoman.png",
      climbing = "resources/images/characters/woman/climbingWoman.png",
      dead = "resources/images/characters/woman/deadWoman.png",
      idle = "resources/images/characters/woman/idleWoman.png",
      jumping = "resources/images/characters/woman/jumpingWoman.png",
      running = "resources/images/characters/woman/runningWoman.png",
    },

    zombie = {
      attacking = "resources/images/characters/zombie/attackingZombie.png",
      climbing = "resources/images/characters/zombie/climbingZombie.png",
      dead = "resources/images/characters/zombie/deadZombie.png",
      idle = "resources/images/characters/zombie/idleZombie.png",
      jumping = "resources/images/characters/zombie/jumpingZombie.png",
      running = "resources/images/characters/zombie/runningZombie.png",
    },
  }

  self.crouchingAcceleration = 8
  self.crouchingJumpSpeed = 6

  self.fallingAcceleration = 32

  self.glidingSpeed = 3
  self.glidingAcceleration = 6

  self.slidingAcceleration = 4
  self.slidingJumpSpeed = 10

  self.sneakingAcceleration = 8
  self.sneakingSpeed = 2
  self.sneakingJumpSpeed = 10

  self.standingAcceleration = 12
  self.standingJumpSpeed = 10

  self.runningAcceleration = 20
  self.runningJumpSpeed = 15
  self.runningSpeed = 5

  self.walkingJumpSpeed = 13
  self.walkingSpeed = 3
  self.walkingAcceleration = 12

  self.wallSlidingJumpSpeedX = 5
  self.wallSlidingJumpSpeedY = 13
  self.wallSlidingAcceleration = 32
  self.wallSlidingSpeed = 5
end

function CharacterComponentManager:createComponent(id, config, transform)
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

function CharacterComponentManager:destroyComponent(id)
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

return CharacterComponentManager
