local function setup()
  require('catppuccin').setup {
    flavour = 'mocha',
  }

  vim.cmd.colorscheme 'catppuccin'
end

return {
  setupTheme = setup,
}
