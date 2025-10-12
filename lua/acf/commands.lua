vim.api.nvim_create_user_command('EditConfig', function(opts)
  vim.cmd 'e ~/.config/nvim'
end, { nargs = 0 })

-- Evaluate expression
vim.api.nvim_create_user_command('DEval', function(opts)
  local expr = opts.args
  local dapui = require 'dapui'
  if not dapui then
    return
  end
  if expr ~= '' then
    dapui.eval(expr)
  else
    vim.ui.input({ propmpt = 'Enter an expression: ' }, function(input)
      if input and input ~= '' then
        dapui.eval(input)
      else
        dapui.eval()
      end
    end)
  end
end, { desc = 'Evaluate expression', nargs = '?' })
