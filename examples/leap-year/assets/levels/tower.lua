local palette = require("assets.scripts.palette")

return {
  {
    components = {
      transform = {},
      bone = {},
      camera = {},
      viewport = {},
    },
  },

  {
    components = {
      sky = {
        colors = {
          palette.blue[1], palette.blue[2], palette.blue[3], 0,
          palette.blue[1], palette.blue[2], palette.blue[3], 1,
        },
      },

      terrain = {
        tileGrid = {
          "                                                                                           ",
          "                                                                                           ",
          "                                                                                           ",
          "                               ###############################                             ",
          "                               #                             #                             ",
          "                               #                             #                             ",
          "                               #                             #                             ",
          "                               #                             #                             ",
          "                               #                             #                             ",
          "                               #                             #                             ",
          "                               #                             #                             ",
          "                               #                             #                             ",
          "                               #                             #                             ",
          "                               #                             #                             ",
          "                               #                             #                             ",
          "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&#                             #&&&&&&&&&&&&&&&&&&&&&&&&&&&&&",
        },
      },
    },
  },

  {
    prototype = "assets.entities.woman",

    components = {
      transform = {
        transform = {2.5, 14.5},
      },
    },
  },
}
