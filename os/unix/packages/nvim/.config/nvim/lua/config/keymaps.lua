-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- buffers navigation with tab
vim.api.nvim_set_keymap("n", "<TAB>", ":bnext<CR>", { noremap = true, silent = true })

-- close buffer
vim.api.nvim_set_keymap("n", "<C-q>", ":bd<CR>", { noremap = true, silent = true })

-- ALL TEXT, PASTE, RENDO, CUT. Ctr r -> rendo
vim.api.nvim_set_keymap("n", "<C-a>", "ggVG", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-v>", '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-z>", "u", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-x>", '"+x', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-d>", ":bd<CR>", { noremap = true, silent = true })

-- Resize splits y sidebar con Alt+hjkl (opt+arrows no llega a nvim en macOS)
-- Normal mode: resize split actual
vim.keymap.set("n", "<M-l>", ":vertical resize +5<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<M-h>", ":vertical resize -5<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<M-k>", ":resize +5<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<M-j>", ":resize -5<CR>", { noremap = true, silent = true })
-- Terminal mode: resize la ventana del sidebar (Claude, toggleterm, etc.)
vim.keymap.set("t", "<M-l>", function()
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_width(win, vim.api.nvim_win_get_width(win) + 5)
end, { noremap = true, silent = true })
vim.keymap.set("t", "<M-h>", function()
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_width(win, vim.api.nvim_win_get_width(win) - 5)
end, { noremap = true, silent = true })
vim.keymap.set("t", "<M-k>", function()
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_height(win, vim.api.nvim_win_get_height(win) + 5)
end, { noremap = true, silent = true })
vim.keymap.set("t", "<M-j>", function()
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_height(win, vim.api.nvim_win_get_height(win) - 5)
end, { noremap = true, silent = true })

-- Mover línea arriba en modo normal con Option + Shift + Up (Alt+Shift+Up)
vim.api.nvim_set_keymap("n", "<A-S-Up>", ":m .-2<CR>==", { noremap = true, silent = true })

-- Mover línea abajo en modo normal con Option + Shift + Down (Alt+Shift+Down)
vim.api.nvim_set_keymap("n", "<A-S-Down>", ":m .+1<CR>==", { noremap = true, silent = true })
