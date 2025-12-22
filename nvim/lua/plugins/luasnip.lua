return {
  "L3MON4D3/LuaSnip",
  config = function()
    require("luasnip").config.set_config({
      enable_autosnippets = true,
      -- This allows you to jump back into snippets
      history = true,
      update_events = "TextChanged,TextChangedI",
    })

    -- Load your snippets from a specific directory
    require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/lua/snippets/" })
  end,
}
