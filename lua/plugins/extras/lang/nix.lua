return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "nix" })
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "nil" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        nil_ls = {
          cmd = { "nil" },
          filetypes = { "nix" },
          settings = {
            nix_ls = {
              formatting = {
                command = "nixpkgs-fmt",
              },
            },
          },
        },
      },
    },
  },
}
