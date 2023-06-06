return {
  {
    "nvim-neorg/neorg",
    enabled = true,
    ft = { "norg" },
    build = ":Neorg sync-parsers",
    opts = {
      load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.concealer"] = {}, -- Adds pretty icons to your documents
        ["core.qol.toc"] = {},
        ["core.dirman"] = { -- Manages Neorg workspaces
          config = {
            workspaces = {
              work = vim.env.HOME .. "/notes/work",
              home = vim.env.HOME .. "/notes/home",
            },
          },
        },
        ["core.presenter"] = {
          config = {
            zen_mode = "zen-mode",
          },
        },
      },
    },
  },
}
