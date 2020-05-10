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
          palette.darkBlue[1], palette.darkBlue[2], palette.darkBlue[3], 1,
          palette.darkBlue[1], palette.darkBlue[2], palette.darkBlue[3], 0,
        },
      },

      terrain = {
        tileSymbols = {
          blueBrick = "#",
        },

        tileGrid = {
          "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#                             #%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%",
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
          "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%",
          "                                                                                           ",
          "                                                                                           ",
          "                                                                                           ",
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
