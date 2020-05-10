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
          palette.blue[1], palette.blue[2], palette.blue[3], 1,
          palette.yellow[1], palette.yellow[2], palette.yellow[3], 1,
        },
      },

      terrain = {
        tileSymbols = {
          greenBrick = "#",
        },

        tileGrid = {
          "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&",
          "                                                                                           ",
          "                                                                                           ",
          "                                                                                           ",
          "                                                                                           ",
          "                                                                                           ",
          "                                                                                           ",
          "                                                                                           ",
          "               #                                                                           ",
          "              ====                                                                         ",
          "        TT    ####                                                                         ",
          "   .:.  TT    ####                                                                         ",
          "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@",
          "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@",
          "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@",
          "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@",
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
