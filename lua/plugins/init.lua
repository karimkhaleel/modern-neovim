return {
  "nvim-lua/plenary.nvim",
  "MunifTanjim/nui.nvim",
  {
    "nvim-tree/nvim-web-devicons",
    dependencies = { "DaikyXendo/nvim-material-icon" },
    config = function()
      require("nvim-web-devicons").setup {
        override = require("nvim-material-icon").get_icons(),
      }
    end,
  },
  { "yamatsum/nvim-nonicons", config = true, enabled = false },
  { "tpope/vim-repeat", event = "VeryLazy" },
  { "nacro90/numb.nvim", event = "BufReadPre", config = true },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      -- char = "▏",
      char = "│",
      filetype_exclude = { "help", "alpha", "dashboard", "NvimTree", "Trouble", "lazy", "mason" },
      show_trailing_blankline_indent = false,
      show_current_context = false,
    },
  },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {
      input = { relative = "editor" },
      select = {
        backend = { "telescope", "fzf", "builtin" },
      },
    },
  },
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    opts = {
      -- background_colour = "#A3CCBE",
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    },
    config = function(_, opts)
      require("notify").setup(opts)
      vim.notify = require "notify"
    end,
  },
  {
    "monaqa/dial.nvim",
    keys = { { "<C-a>", mode = { "n", "v" } }, { "<C-x>", mode = { "n", "v" } }, { "g<C-a>", mode = { "v" } }, { "g<C-x>", mode = { "v" } } },
    -- stylua: ignore
    init = function()
      vim.api.nvim_set_keymap("n", "<C-a>", require("dial.map").inc_normal(), { desc = "Increment", noremap = true })
      vim.api.nvim_set_keymap("n", "<C-x>", require("dial.map").dec_normal(), { desc = "Decrement", noremap = true })
      vim.api.nvim_set_keymap("v", "<C-a>", require("dial.map").inc_visual(), { desc = "Increment", noremap = true })
      vim.api.nvim_set_keymap("v", "<C-x>", require("dial.map").dec_visual(), { desc = "Decrement", noremap = true })
      vim.api.nvim_set_keymap("v", "g<C-a>", require("dial.map").inc_gvisual(), { desc = "Increment", noremap = true })
      vim.api.nvim_set_keymap("v", "g<C-x>", require("dial.map").dec_gvisual(), { desc = "Decrement", noremap = true })
    end,
  },
  {
    "andymass/vim-matchup",
    event = { "BufReadPost" },
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        keymaps = {
          insert = "<C-g>s",
          insert_line = "<C-g>S",
          normal = "ys",
          normal_cur = "yss",
          normal_line = "yS",
          normal_cur_line = "ySS",
          visual = "<Leader>S",
          visual_line = "gS",
          delete = "ds",
          change = "cs",
          change_line = "cS",
        },
      }
    end,
  },
  {
    "numToStr/Comment.nvim",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    keys = { { "gc", mode = { "n", "v" } }, { "gcc", mode = { "n", "v" } }, { "gbc", mode = { "n", "v" } } },
    config = function(_, _)
      local opts = {
        ignore = "^$",
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      }
      require("Comment").setup(opts)
    end,
  },
  -- session management
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help" } },
    -- stylua: ignore
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
  },
}
