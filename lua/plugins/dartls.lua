local path = require("utils.path")
local utils = require("utils.utils")

return {
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local flutter_sdk_path = utils.flutter_sdk_path()
      require("lspconfig").dartls.setup({
        cmd = { "dart", "language-server", "--protocol=lsp" },
        settings = {
          dart = {
            completeFunctionCalls = true,
            showTodos = true,
            analysisExcludedFolders = {
              path.join(flutter_sdk_path, "packages"),
              path.join(utils.home_path, ".pub-cache"),
            },
            updateImportsOnRename = true,
          },
        },
      })
    end,
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = "williamboman/mason.nvim",
    opts = function()
      local dap = require("dap")
      local flutter_sdk = utils.flutter_sdk_path()
      local flutter_sdk_path = path.join(flutter_sdk, "bin/flutter")
      local dask_sdk_path = path.join(flutter_sdk, "bin/cache/dart-sdk/bin")

      dap.adapters.dart = {
        type = "executable",
        command = "dart",
        args = { "debug_adapter" },
      }
      dap.adapters.flutter = {
        type = "executable",
        command = "flutter",
        args = { "debug_adapter" },
      }
      dap.configurations.dart = {
        {
          type = "dart",
          request = "launch",
          name = "Launch dart",
          dartSdkPath = dask_sdk_path,
          flutterSdkPath = flutter_sdk_path,
          program = function()
            return vim.fn.input("Program: ", "lib/main.dart")
          end,
          cwd = "${workspaceFolder}",
        },
        {
          type = "flutter",
          request = "launch",
          name = "Launch flutter with program",
          dartSdkPath = dask_sdk_path,
          flutterSdkPath = flutter_sdk_path,
          program = function()
            return vim.fn.input("Program: ", "lib/main.dart")
          end,
          cwd = "${workspaceFolder}",
        },
      }
    end,
  },
}
