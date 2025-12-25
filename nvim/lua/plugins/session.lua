return {
  "rmagatti/auto-session",
  dependencies = { "nvim-telescope/telescope.nvim" }, -- Ensure telescope loads first
  config = function()
    require("auto-session").setup({
      auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      
      -- This section tells auto-session to load the extension for us
      session_lens = {
        buftypes_to_ignore = {},
        load_on_setup = true, -- This loads the 'session-lens' extension automatically
        theme_conf = { border = true },
        previewer = false,
      },

    })

    -- Keymap: Use the command string instead of requiring the module.
    -- This is safer and avoids startup crashes.
    vim.keymap.set("n", "<Leader>zl", "<cmd>Telescope session-lens search_session<CR>", {

      noremap = true,
      silent = true,
      desc = "Search Sessions",
    })

  end,
}
