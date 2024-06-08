return {
  {
    "rcarriga/nvim-dap-ui",
    opts = {
      layouts = {
        {
          -- You can change the order of elements in the sidebar
          elements = {
            -- Provide IDs as strings or tables with "id" and "size" keys
            {
              id = "scopes",
              size = 0.30, -- Can be float or integer > 1
            },
            { id = "stacks", size = 0.50 },
            { id = "breakpoints", size = 0.20 },
            -- { id = "watches", size = 0.25 },
          },
          size = 40,
          position = "left", -- Can be "left" or "right"
        },
        {
          elements = {
            "repl",
            -- "console",
          },
          size = 10,
          position = "bottom", -- Can be "bottom" or "top"
        },
      },
    },
  },
}
