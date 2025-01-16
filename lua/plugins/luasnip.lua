return {
  {
    "L3MON4D3/LuaSnip",
    config = function(_, _)
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/lua/config/snippets" } }) -- load snippets paths
      require("luasnip").config.setup({
        update_events = "TextChanged,TextChangedI",
        enable_autosnippets = true,
      })
    end,
  },
}
