return {
  {
    "nvim-cmp",
    dependencies = {
      {
        "Exafunction/codeium.nvim",
        dependencies = {
          "nvim-lua/plenary.nvim",
          "hrsh7th/nvim-cmp",
        },
        config = function()
          require("codeium").setup({})
        end,
      },
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, 2, {
        name = "codeium",
        group_index = 1,
        priority = 50,
      })
    end,
  },
}
