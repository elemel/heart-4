local palette = require("assets.palette")

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
    prototype = "assets.entities.man",

    components = {
      transform = {
        transform = {2.5, 11.5},
      },
    },
  },
}
