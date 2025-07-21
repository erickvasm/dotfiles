-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- buffers navigation with tab
vim.api.nvim_set_keymap("n", "<TAB>", ":bnext<CR>", { noremap = true, silent = true })

-- ALL TEXT, PASTE, RENDO, CUT
vim.api.nvim_set_keymap("n", "<C-a>", "ggVG", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-v>", '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-z>", "u", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-x>", '"+x', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-d>", ":bd<CR>", { noremap = true, silent = true })
