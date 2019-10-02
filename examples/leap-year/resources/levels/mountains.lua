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
    prototype = "resources.entities.woman",
    transform = {2.5, 11.5},
  },
}
