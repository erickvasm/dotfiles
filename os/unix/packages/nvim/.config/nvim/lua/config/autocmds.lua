-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Sync colorscheme with macOS dark/light mode
-- NOTA: solo dispara al abrir nvim (VimEnter) o al enfocar la ventana (FocusGained).
-- Si el modo cambia mientras nvim está abierto y enfocado, NO actualiza automáticamente.
-- Limitación: en macOS "Auto" mode el sistema puede no retornar "Dark" consistentemente.
if vim.fn.has("mac") == 1 then
  local function is_dark_mode()
    local result = vim.fn.system("defaults read -g AppleInterfaceStyle 2>/dev/null")
    return vim.trim(result) == "Dark"
  end

  local function apply_appearance()
    if is_dark_mode() then
      vim.o.background = "dark"
      vim.cmd("colorscheme tokyonight-night")
    else
      vim.o.background = "light"
      vim.cmd("colorscheme tokyonight-day")
    end
  end

  vim.api.nvim_create_autocmd({ "VimEnter", "FocusGained" }, {
    callback = apply_appearance,
  })
end

-- Guarda todos los buffers al salir de insert mode o al modificar texto (autosave)
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
  pattern = { "*" },
  command = "silent! wall",
  nested = true,
})

-- Mostrar ventana flotante con detalles al poner el cursor sobre un error
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false })
  end,
})
