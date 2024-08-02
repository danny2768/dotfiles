-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- map leader + n to focus neo-tree
map("n", "<leader>n", ":Neotree focus<cr>", vim.tbl_extend("force", opts, { desc = "Focus NeoTree" }))

-- map leader + n to focus last buffer
map("n", "<leader>N", ":b#<cr>", vim.tbl_extend("force", opts, { desc = "Switch to last buffer" }))

-- map leater + tt to toggle transparency
map(
  "n",
  "<leader>tt",
  ":TransparentToggle<CR>",
  vim.tbl_extend("force", opts, { desc = "Toggle background transparency" })
)
