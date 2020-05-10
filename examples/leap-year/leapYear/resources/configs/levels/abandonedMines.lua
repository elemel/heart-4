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
          palette.black[1], palette.black[2], palette.black[3], 1,
        },
      },

      terrain = {
        tileSymbols = {
          largeOrangeTree = "O",
        },

        tileGrid = {
          "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%",
          "                                                                                           ",
          "                                                                                           ",
          "                                                                                           ",
          "                                                                                           ",
          "                                                                                           ",
          "                                                                                           ",
          "                                                                                           ",
          "                                                                                           ",
          "                                                                                           ",
          "                                                                                           ",
          "                                                                                           ",
          "                                                                                           ",
          "                                                                                           ",
          "                                                                                           ",
          "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%",
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
