return {
  {
    "L3MON4D3/LuaSnip",
    config = function(_, _)
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/lua/config/snippets" } }) -- load snippets paths
    end,
  },
}
