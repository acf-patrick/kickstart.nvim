-- autopairs
-- https://github.com/windwp/nvim-autopairs

return {
  'windwp/nvim-autopairs',
  dependencies = { 'nvim-cmp/blink.cmp' },
  event = 'InsertEnter',
  opts = {
    map_cr = false,
  },
}
