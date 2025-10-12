local Component = require('lualine.component'):extend()

function Component:init(opts)
  Component.super.init(self, opts)
end

function Component:update_status()
  return os.date(self.options.format or '%H:%M', os.time())
end

return Component
