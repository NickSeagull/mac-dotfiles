local api = vim.api
local Module = {}

function Module.makeScratch()
  api.nvim_command('enew')
  vim.bo[0].buftype=nofile
  vim.bo[0].bufhidden=hide
  vim.bo[0].swapfile=false
end

return Module