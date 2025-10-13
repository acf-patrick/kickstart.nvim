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
  local frame = body and body.frame
  if not frame then
    return -- no frame yet
  end

  local path = frame.source and frame.source.path
  if not path then
    return -- no file path
  end

  vim.api.nvim_command('edit ' .. path)
  vim.api.nvim_win_set_cursor(0, { frame.line or 1, 0 })
  vim.cmd 'normal! zz'
end

-- DAP keymaps
-- Debugger related shortcuts are prefixed with 'd' letter

vim.keymap.set('n', '<leader>db', '<cmd> DapToggleBreakpoint <CR>', { desc = 'Add breakpoint at line' })
vim.keymap.set('n', '<leader>dr', '<cmd> DapContinue <CR>', { desc = 'Start/Continue the debugger' })
vim.keymap.set('n', '<leader>dn', dap.step_over, { desc = 'Step Over/Next' })
vim.keymap.set('n', '<leader>dsi', dap.step_into, { desc = 'Step Into' })
vim.keymap.set('n', '<leader>dso', dap.step_out, { desc = 'Step Out' })
vim.keymap.set('n', '<leader>dc', dap.run_to_cursor, { desc = 'Run to Cursor' })
vim.keymap.set('n', '<leader>dxb', function()
  vim.ui.input({ prompt = 'Enter condition: ' }, function(cond)
    dap.set_breakpoint(cond and cond ~= '' and cond or nil)
  end)
end, { desc = 'Add breakpoint at line' })

-- Evaluate expression
vim.keymap.set('n', '<F12>', function()
  local dapui = require 'dapui'
  if dapui then
    dapui.eval()
  end
end, { desc = 'Evaluate expression' })

-- Jump to paused line
vim.keymap.set('n', '<leader>dj', function()
  local session = dap.session()
  if not session then
    vim.notify('No active debug session', vim.log.levels.WARN)
    return
  end

  local frame = session.current_frame
  if not frame or not frame.source or not frame.source.path then
    vim.notify('No frame info available', vim.log.levels.WARN)
    return
  end

  -- open related file at instruction
  vim.cmd('edit ' .. frame.source.path)
  vim.api.nvim_win_set_cursor(0, { frame.line or 1, 0 })
end, { desc = 'Jump to paused line' })

-- Terminate debugger
vim.keymap.set('n', '<leader>dq', function()
  dap.terminate()
  local dapui = require 'dapui'
  if dapui ~= nil then
    dapui.close() -- event_terminated not trigger by some adapters
  end
end, { desc = 'Terminate debugger' })

-- Close dap-ui
vim.keymap.set('n', '<leader>duc', function()
  local dapui = require 'dapui'
  if dapui ~= nil then
    dapui.close()
  end
end, {
  desc = 'Close dap-ui',
  noremap = true,
  silent = true,
})

vim.fn.sign_define('DapStopped', {
  text = '👉',
  texthl = 'DapStoppedLine',
  linehl = 'Visual',
  numhl = '',
})

vim.fn.sign_define('DapBreakpointCondition', {
  text = '⦿',
  texthl = 'DapBreakpoint',
  linehl = '',
  numhl = '',
})

vim.fn.sign_define('DapBreakpoint', {
  text = '●',
  texthl = 'DapBreakpoint',
  linehl = '',
  numhl = '',
})

vim.cmd [[
    highlight DapBreakpoint guifg=#ff5555
    highlight DapStoppedLine guibg=#282c34
]]

vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = '#E06C75' }) -- red
vim.api.nvim_set_hl(0, 'DapBreakpointCondition', { fg = '#E5C07B' }) -- yellow
