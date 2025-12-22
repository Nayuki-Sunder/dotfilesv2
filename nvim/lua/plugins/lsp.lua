return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        -- Remove "pyright" from this list if it's there
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")

      -- DO NOT setup pyright via lspconfig here
      -- If you previously had a custom pyright setup, remove it
    end,
  },
}
