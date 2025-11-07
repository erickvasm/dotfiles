return {
  -- 🔇 desactivar texto inline de diagnósticos
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = false, -- desactiva los mensajes anaranjados inline
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      },
    },
  },
}
