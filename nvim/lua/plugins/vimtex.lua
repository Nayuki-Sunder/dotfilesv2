return {
  "lervag/vimtex",
  lazy = false, -- Vimtex handles its own loading
  config = function()
    vim.g.vimtex_view_method = "zathura"
    -- Configure Zathura to use your custom path and environment
    vim.g.vimtex_view_zathura_general_options = 
      "-x 'ZATHURA_PLUGINS_PATH=/usr/local/lib/zathura /home/nyxx/.local/bin/zathura'"
    vim.g.vimtex_view_zathura_options = "--synctex"
    -- Or alternatively, set the viewer command directly:
    vim.g.vimtex_view_general_viewer = "/home/nyxx/.local/bin/zathura"
    vim.g.vimtex_view_general_options = 
      "ZATHURA_PLUGINS_PATH=/usr/local/lib/zathura %f"

    -- Set the compiler to use latexmk
    vim.g.vimtex_compiler_method = "latexmk"
  end,
}
