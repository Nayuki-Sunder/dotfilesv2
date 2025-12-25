return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    -- Disable ghost_text to prevent visual artifacts
    opts.experimental = {
      ghost_text = false,
    }
  end,
}
