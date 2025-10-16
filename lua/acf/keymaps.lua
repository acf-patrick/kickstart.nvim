vim.keymap.set('n', '<C-Up>', ':resize +2<CR>')
vim.keymap.set('n', '<C-Down>', ':resize -2<CR>')
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>')
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>')

-- clang code suggestion
vim.keymap.set('n', '<leader>ca', function()
  vim.lsp.buf.code_action()
end, { noremap = true, silent = true })

vim.keymap.set('n', '<leader>ce', function()
  vim.diagnostic.setqflist {
    severity = vim.diagnostic.severity.ERROR,
  }
end, { noremap = true, silent = true })

vim.keymap.set('n', '<leader>cw', function()
  vim.diagnostic.setqflist {
    severity = vim.diagnostic.severity.WARN,
  }
end, { noremap = true, silent = true })

vim.keymap.set('n', '<C-Space>', function()
  vim.lsp.buf.hover()
end)

vim.keymap.set('n', '<leader>cs', '<cmd>Telescope colorscheme<CR>', { desc = 'Switch color scheme' })
