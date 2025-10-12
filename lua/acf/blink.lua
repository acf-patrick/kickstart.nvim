vim.keymap.set('i', '<CR>', function()
  local blink = require 'blink.cmp'
  if blink.is_visible() then
    blink.accept()
  else
    return '<CR>'
  end
end, { expr = true, noremap = true })
