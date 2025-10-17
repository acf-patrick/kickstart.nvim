-- You can add your own plugins here or in other files in this directory!
--
-- See the kickstart.nvim README for more information

return {
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      scope = { enabled = true },
      indent = {
        char = '┊',
        highlight = { 'IblIndent' },
      },
    },
    config = function(_, opts)
      require('ibl').setup(opts)
      vim.api.nvim_set_hl(0, 'IblIndent', { fg = '#3b3b3b', nocombine = true })
    end,
  },
  {
    'SmiteshP/nvim-navic',
    config = function()
      local navic = require 'nvim-navic'
      navic.setup {
        lsp = { auto_attach = true },
      }
    end,
  },
  { 'LunarVim/breadcrumbs.nvim', dependencies = { 'SmiteshP/nvim-navic' } },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    options = {
      theme = 'auto',
      globalstatus = true,
    },
    config = function()
      local lualine_time = require 'acf.lualine_time'
      local lualine = require 'lualine'
      local configs = lualine.get_config()
      configs.sections.lualine_y = { lualine_time }
      lualine.setup(configs)
    end,
  },
  { 'nvim-neotest/nvim-nio' },
  {
    'mfussenegger/nvim-dap',
  },
  {
    'rcarriga/nvim-dap-ui',
    event = 'VeryLazy',
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-neotest/nvim-nio',
    },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

      dapui.setup {
        layouts = {
          { -- RIGHT SIZE : variables, watches, breakpoints, stacks
            elements = {
              { id = 'scopes', size = 0.35 },
              { id = 'watches', size = 0.25 },
              { id = 'breakpoints', size = 0.2 },
              { id = 'stacks', size = 0.2 },
            },
            size = 60,
            position = 'right',
          },
          { -- BOTTOM: REPL and console/log
            elements = {
              { id = 'repl', size = 0.5 },
              { id = 'console', size = 0.5 },
            },
            size = 15, -- height in lines
            position = 'bottom',
          },
        },
        controls = {
          enabled = true,
          element = 'repl',
        },
      }

      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end

      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end

      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end

      dap.listeners.before.attach['dapui_config'] = function()
        dapui.open()
      end

      dap.listeners.before.launch['dapui_config'] = function()
        dapui.open()
      end
    end,
  },
  {
    'jay-babu/mason-nvim-dap.nvim',
    event = 'VeryLazy',
    dependencies = {
      'mason-org/mason.nvim',
      'mfussenegger/nvim-dap',
    },
    opts = {
      handler = {},
    },
  },
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      local neogit = require 'neogit'
      neogit.setup {
        kind = 'floating',
      }
    end,
  },
}
