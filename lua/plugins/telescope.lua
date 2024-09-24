return {
  "nvim-telescope/telescope.nvim",
  keys = {
    {
      "<leader>sD",
      function()
        -- sorts by severity
        require("telescope.builtin").diagnostics({ sort_by = "severity" })
      end,
      desc = "Workspace Diagnostics",
    },
  },
  opts = {
    defaults = {
      mappings = {
        i = {
          ["<S-Down>"] = function(...)
            require("telescope.actions").cycle_history_next(...)
          end,
          ["<S-Up>"] = function(...)
            require("telescope.actions").cycle_history_prev(...)
          end,
        },
      },
    },
  },
}
