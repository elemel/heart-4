local palette = require("leapYear.resources.configs.palette")

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
    prototype = "leapYear.resources.configs.entities.man",

    components = {
      transform = {
        transform = {2.5, 14.5},
      },
    },
  },
}
