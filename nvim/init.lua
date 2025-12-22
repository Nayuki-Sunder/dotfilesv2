-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

if vim.loader then
  vim.loader.enable()
end
vim.fn.setenv("PATH", vim.fn.getenv("PATH") .. ":" .. vim.fn.expand("~/anaconda3/envs/gen/"))
require("config.lazy")
