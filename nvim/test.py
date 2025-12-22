return {
    {
  "williamboman/mason-lspconfig.nvim",
  opts = {
    ensure_installed = {
    },
  },
},

{
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
  },
  config = function()
    local lspconfig = require("lspconfig")
  end,
},
}
