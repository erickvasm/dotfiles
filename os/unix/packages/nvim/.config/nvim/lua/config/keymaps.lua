-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- buffers navigation with tab
vim.api.nvim_set_keymap("n", "<TAB>", ":bnext<CR>", { noremap = true, silent = true })

-- ALL TEXT, PASTE, RENDO, CUT. Ctr r -> rendo
vim.api.nvim_set_keymap("n", "<C-a>", "ggVG", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-v>", '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-z>", "u", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-x>", '"+x', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-d>", ":bd<CR>", { noremap = true, silent = true })

-- Mover línea arriba en modo normal con Option + Shift + Up (Alt+Shift+Up)
vim.api.nvim_set_keymap("n", "<A-S-Up>", ":m .-2<CR>==", { noremap = true, silent = true })

-- Mover línea abajo en modo normal con Option + Shift + Down (Alt+Shift+Down)
vim.api.nvim_set_keymap("n", "<A-S-Down>", ":m .+1<CR>==", { noremap = true, silent = true })
