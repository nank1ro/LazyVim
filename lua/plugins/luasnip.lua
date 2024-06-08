return {
  {
    "L3MON4D3/LuaSnip",
    tag = "v2.3.0",
    config = function(_, _)
      print("Loading LuaSnip")
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./lua/config/snippets" } }) -- load snippets paths
    end,
  },
}
