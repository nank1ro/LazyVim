return {
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    cmd = {
      "ObsidianOpen",
      "ObsidianNew",
      "ObsidianSearch",
      "ObsidianTomorrow",
      "ObsidianYesterday",
      "ObsidianToday",
      "ObsidianQuickSwitch",
    },
    keys = {
      { "<leader>fo", "<cmd>ObsidianSearch<cr>", desc = "Search Obsidian" },
      { "<C-c>", "<cmd>ObsidianToggleCheckbox<cr>", desc = "Toggle obsidian checkbox" },
    },
    ft = "markdown",
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",
      -- Optional
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "personal",
          path = "~/Google Drive/My Drive/Obsidian's notes/Obsidian's notes",
        },
      },
    },
  },
}
