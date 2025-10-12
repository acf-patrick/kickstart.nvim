-- You can add your own plugins here or in other files in this directory!
--
-- See the kickstart.nvim README for more information

return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
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
      dapui.setup()

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
      'willliamboman/mason.nvim',
      'mfussenegger/nvim-dap',
    },
    opts = {
      handler = {},
    },
  },
}
