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
}
