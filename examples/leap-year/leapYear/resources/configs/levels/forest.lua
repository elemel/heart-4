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
          palette.pink[1], palette.pink[2], palette.pink[3], 1,
        },
      },

      terrain = {
        tileSymbols = {
          largeRedTree = "R",
          largeYellowTree = "Y",
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
          "        YY    ####          RR                                                             ",
          "        YY    ####          RR                                                             ",
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
