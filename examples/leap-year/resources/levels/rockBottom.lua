local palette = require("resources.scripts.palette")

return {
  {
    components = {
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
    prototype = "resources.entities.man",
    transform = {2.5, 11.5},
  },
}
