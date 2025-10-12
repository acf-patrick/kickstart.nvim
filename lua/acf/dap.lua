local dap = require 'dap'

dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = os.getenv 'HOME' .. '/.local/share/nvim/mason/bin/OpenDebugAD7',
  name = 'Launch file',
}

dap.configurations.cpp = {
  {
    name = 'Launch GCC binary',
    type = 'cppdbg',
    request = 'launch',
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
    program = function()
      return vim.fn.input('Path to executable : ', vim.fn.getcwd() .. '/', 'file')
    end,
  },
}

-- jump to current frame
dap.listeners.after.event_stopped['jump_to_frame'] = function(_, body)
  vim.api.nvim_command('edit ' .. body.source.path)
  vim.api.nvim_win_set_cursor(0, { body.frame.line, 0 })
end

-- DAP keymaps
vim.keymap.set('n', '<leader>db', '<cmd> DapToggleBreakpoint <CR>', { desc = 'Add breakpoint at line' })
vim.keymap.set('n', '<leader>dr', '<cmd> DapContinue <CR>', { desc = 'Start or continue the debugger' })
-- TODO : add other keymap for step into/after/out

vim.keymap.set('n', '<leader>duc', function()
  local dapui = require 'dapui'
  dapui.close()
end, { noremap = true, silent = true })

vim.fn.sign_define('DapBreakpoint', {
  text = '🛑',
  texthl = 'DapBreakpoint',
  linehl = '',
  numhl = '',
})

vim.cmd [[
    highlight DapBreakpoint guifg=#ff5555
    highlight DapStoppedLine guibg=#282c34
]]
