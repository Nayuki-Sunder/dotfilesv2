return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      -- Ensure texlab is installed and configured
      texlab = {
        keys = {
          { "<Leader>Z", "<plug>(vimtex-doc-package)", desc = "Vimtex Docs", silent = true },
        },
        settings = {
          texlab = {
            build = {
              -- Automatically build on save (optional, since latexmk does this too)
              onSave = true,
            },
            chktex = {
              -- Enable linter for finding bugs/warnings
              onOpenAndSave = true,
              onEdit = true,
            },
            diagnostics = {
              -- Delay in ms before showing errors
              delay = 300,
            },
            formatterLineLength = 80,
          },
        },
      },
    },
  },
}
