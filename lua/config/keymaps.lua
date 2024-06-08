-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

local lazyterm = function()
  LazyVim.terminal(nil, { cwd = LazyVim.root() })
end

map({ "i", "x", "n", "s" }, "<Char-0xAA>", "<cmd>w<cr><esc>", { desc = "Save File" })
map({ "i", "x", "n", "s" }, "<Char-0xAC>", "<cmd>Neotree toggle<CR>", { desc = "Toogle NeoTree" })
map({ "i", "x", "n", "s" }, "<Char-0xB0>", lazyterm, { desc = "Terminal (Root Dir)" })
map("t", "<Char-0xB0>", "<cmd>close<cr>", { desc = "Hide Terminal" })
