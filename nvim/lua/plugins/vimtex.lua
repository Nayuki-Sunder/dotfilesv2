return {
  "lervag/vimtex",
  lazy = false, -- Vimtex handles its own loading
  config = function()
    vim.g.vimtex_view_method = "zathura"
    -- This ensures Zathura focuses when you compile
    vim.g.vimtex_view_general_viewer = "zathura"
    -- Set the compiler to use latexmk (which you've already set up)
    vim.g.vimtex_compiler_method = "latexmk"
  end,
}
