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
          0, 0, 0, 0,
          0x30 / 0xff, 0x9f / 0xff, 0xed / 0xff, 1,
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
    prototype = "resources.entities.woman",
    transform = {2.5, 14.5},
  },
}
