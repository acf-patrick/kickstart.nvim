vim.keymap.set('n', '<C-Up>', ':resize +2<CR>')
vim.keymap.set('n', '<C-Down>', ':resize -2<CR>')
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>')
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>')

-- clang code suggestion
vim.keymap.set('n', '<leader>ca', function()
  vim.lsp.buf.code_action()
end, { noremap = true, silent = true, desc = 'Show code actions' })

vim.keymap.set('n', '<leader>ce', function()
  vim.diagnostic.setqflist {
    severity = vim.diagnostic.severity.ERROR,
  }
end, { noremap = true, silent = true, desc = 'Show code actions for Errors' })

vim.keymap.set('n', '<leader>cw', function()
  vim.diagnostic.setqflist {
    severity = vim.diagnostic.severity.WARN,
  }
end, { noremap = true, silent = true, desc = 'Show code actions for Warnings' })

vim.keymap.set('n', '<C-Space>', function()
  vim.lsp.buf.hover()
end)

vim.keymap.set('n', '<leader>cs', '<cmd>Telescope colorscheme<CR>', { desc = 'Switch color scheme' })

vim.keymap.set('n', '<leader>h', function()
  local enabled = vim.lsp.inlay_hint.is_enabled()
  vim.lsp.inlay_hint.enable(not enabled)
end, { desc = 'Toggle Inlay Hints' })
