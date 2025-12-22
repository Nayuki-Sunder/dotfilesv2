return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Disable default pyright
        pyright = nil,
      },
    },
    config = function(_, opts)
      local lspconfig = require("lspconfig")

      -- Manual pyright setup using conda env
      lspconfig.pyright.setup({
        cmd = { "/home/nyxx/anaconda3/envs/gen/bin/pyright-python-langserver", "--stdio" },
        settings = {
          pyright = {
            python = {
              -- Optional: specify interpreter (helps with diagnostics)
              pythonPath = "/home/nyxx/anaconda3/envs/gen/bin/python",
            },
          },
          python = {
            analysis = {
              typeCheckingMode = "basic", -- or "off", "strict"
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
            },
          },
        },
      })

      -- Rest of LSP setup (if needed)
    end,
  },
}
