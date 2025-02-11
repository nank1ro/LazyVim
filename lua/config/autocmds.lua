-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Sets the title of the ghostty terminal to the current directory
if vim.fn.getenv("TERM_PROGRAM") == "ghostty" then
  vim.opt.title = true
  local cwd = vim.fn.getcwd()
  local home = vim.fn.expand("~")
  vim.opt.titlestring = cwd:gsub(home, "~")
end
