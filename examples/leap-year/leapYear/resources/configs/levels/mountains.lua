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
          palette.black[1], palette.black[2], palette.black[3], 1,
          palette.blue[1], palette.blue[2], palette.blue[3], 1,
        },
      },

      terrain = {
        tileSymbols = {
          blueBrick = "#",
        },

        tileGrid = {
          "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&#                             #&&&&&&&&&&&&&&&&&&&&&&&&&&&&&",
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
          "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#                             #%%%%%%%%%%%%%%%%%%%%%%%%%%%%%",
          "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#                             #%%%%%%%%%%%%%%%%%%%%%%%%%%%%%",
          "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#                             #%%%%%%%%%%%%%%%%%%%%%%%%%%%%%",
          "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#                             #%%%%%%%%%%%%%%%%%%%%%%%%%%%%%",
        },
      },
    },
  },

  {
    prototype = "leapYear.resources.configs.entities.man",

    components = {
      transform = {
        transform = {2.5, 11.5},
      },
    },
  },
}
