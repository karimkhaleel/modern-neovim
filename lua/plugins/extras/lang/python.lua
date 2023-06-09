return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "python" })
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require "null-ls"
      local function insert(...)
        for _, value in ipairs { ... } do
          table.insert(opts.sources, value)
        end
      end
      insert(
        nls.builtins.formatting.black,
        nls.builtins.formatting.isort.with { extra_args = { "--profile", "black" } },
        nls.builtins.diagnostics.flake8,
        nls.builtins.diagnostics.mypy
      )
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "debugpy" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pylsp = {
          cmd = { "pylsp" },
          filetypes = { "python" },
          root_dir = require("lspconfig.util").root_pattern(".git", "setup.py", "setup.cfg", "pyproject.toml", "requirements.txt"),
          settings = {
            pylsp = {
              configurationSources = { "flake8" },
              plugins = {
                pycodestyle = { enabled = false },
                pydocstyle = { enabled = false },
                pylint = { enabled = false },
                yapf = { enabled = false },
                pyflakes = { enabled = false },
              },
            },
          },
        },
      },
    },
    setup = {
      pylsp = function(_, opts)
        local lsp_utils = require "plugins.lsp.utils"
        lsp_utils.on_attach(function(client, buffer)
          -- stylua: ignore
          if client.name == "python-lsp-server" then
            vim.keymap.set("n", "<leader>tC", function() require("dap-python").test_class() end,
              { buffer = buffer, desc = "Debug Class" })
            vim.keymap.set("n", "<leader>tM", function() require("dap-python").test_method() end,
              { buffer = buffer, desc = "Debug Method" })
            vim.keymap.set("v", "<leader>tS", function() require("dap-python").debug_selection() end,
              { buffer = buffer, desc = "Debug Selection" })
          end
        end)
        return true
      end,
    },
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = { "mfussenegger/nvim-dap-python" },
    opts = {
      setup = {
        debugpy = function(_, _)
          require("dap-python").setup("python", {})
          table.insert(require("dap").configurations.python, {
            type = "python",
            request = "attach",
            connect = {
              port = 5678,
              host = "127.0.0.1",
            },
            mode = "remote",
            name = "container attach debug",
            cwd = vim.fn.getcwd(),
            pathmappings = {
              {
                localroot = function()
                  return vim.fn.input("local code folder > ", vim.fn.getcwd(), "file")
                end,
                remoteroot = function()
                  return vim.fn.input("container code folder > ", "/", "file")
                end,
              },
            },
          })
          table.insert(require("dap").configurations.python, {
            type = "python",
            request = "launch",
            name = "Django",
            program = vim.fn.getcwd() .. "/manage.py",
            args = { "runserver" },
            python = vim.fn.trim(vim.fn.system "which python"),
          })
        end,
      },
    },
  },
  {
    "microsoft/python-type-stubs",
    cond = false,
  },
}
