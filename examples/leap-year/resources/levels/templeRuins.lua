local palette = require("resources.scripts.palette")

return {
  {
    components = {
      transform = {},
      camera = {},
      viewport = {},
    },
  },

  {
    components = {
      sky = {
        colors = {
          palette.lightBlue[1], palette.lightBlue[2], palette.lightBlue[3], 1,
          palette.brightBlue[1], palette.brightBlue[2], palette.brightBlue[3], 1,
        },
      },

      terrain = {
        tileSymbols = {
          yellowBrick = "#",
        },

        tileGrid = {
          "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&",
          "                                                                                            ",
          "                                                                                            ",
          "                              ###############################                               ",
          "                              #                             #                               ",
          "                              #                             #                               ",
          "                              #                             #                               ",
          "                              #                             #                               ",
          "                              #                             #                               ",
          "                              #                             #                               ",
          "        TT                    #                             #                               ",
          "        TT                    #                             #                               ",
          "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#                             #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@",
          "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#                             #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@",
          "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#                             #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@",
          "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#                             #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@",
        },
      },
    },
  },

  {
    prototype = "resources.entities.man",

    components = {
      transform = {
        transform = {2.5, 11.5},
      },
    },
  },
}
