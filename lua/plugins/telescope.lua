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
  opts = function()
    local custom_pickers = require("custom.telescope_custom_pickers")
    return {
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
      pickers = {
        live_grep = {
          path_display = { "shorten" },
          mappings = {
            i = {
              ["<c-f>"] = custom_pickers.actions.set_extension,
              ["<c-l>"] = custom_pickers.actions.set_folders,
            },
          },
        },
      },
    }
  end,
}
