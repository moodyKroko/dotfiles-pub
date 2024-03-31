-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- local opts = { noremap = true, silent = true }
local keymap = vim.keymap

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

keymap.set(
  "n",
  "<leader>cs",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Substitue word globally" }
)

keymap.set("n", "<leader>snt", [[:Telescope notify<CR>]], { desc = "Telescope Notification" })
