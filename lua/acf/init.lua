vim.opt.rnu = true

vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

-- use space
vim.opt.expandtab = true

-- number of spaces for a tab
vim.opt.tabstop = 4

-- number of spaces for indentation
vim.opt.shiftwidth = 4

vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

vim.keymap.set('n', '<C-Up>', ':resize +2<CR>')
vim.keymap.set('n', '<C-Down>', ':resize -2<CR>')
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>')
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>')

-- DAP keymaps
vim.keymap.set('n', '<leader>db', '<cmd> DapToggleBreakpoint <CR>', { desc = 'Add breakpoint at line' })
vim.keymap.set('n', '<leader>dr', '<cmd> DapContinue <CR>', { desc = 'Start or continue the debugger' })
-- TODO : add other keymap for step into/after/out

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

-- make file explorer follow code buffer
require('neo-tree').setup {
  sources = { 'filesystem', 'buffers', 'git_status' },
  filesystem = {
    follow_current_file = {
      enabled = true,
    },
    use_libuv_file_watcher = true,
  },
}
