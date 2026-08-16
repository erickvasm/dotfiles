-- PYTHON RUN + REPL — ejecutar archivo actual y entorno interactivo (RAG/IA)
--
-- CODE RUNNER:
--   <leader>rr  → :RunCode — corre archivo actual en terminal flotante (toggleterm)
--
-- REPL (iron.nvim) — prefiere ipython si está en PATH, fallback python3:
--   <leader>ii  → abre/enfoca REPL
--   <leader>il  → envía línea actual al REPL
--   <leader>iv  (visual) → envía selección al REPL
--   <leader>ic  → cierra REPL

return {
  {
    "akinsho/toggleterm.nvim",
    opts = {},
  },
  {
    "CRAG666/code_runner.nvim",
    dependencies = { "akinsho/toggleterm.nvim" },
    keys = {
      { "<leader>rr", "<cmd>RunCode<cr>", desc = "Run Code" },
    },
    opts = {
      mode = "toggleterm",
      focus = true,
      startinsert = true,
      filetype = {
        python = "python3 -u",
      },
    },
  },
  {
    "Vigemus/iron.nvim",
    keys = {
      { "<leader>ii", desc = "Open/focus REPL" },
      { "<leader>il", desc = "Send line to REPL" },
      { "<leader>iv", mode = "v", desc = "Send selection to REPL" },
      { "<leader>ic", desc = "Close REPL" },
    },
    config = function()
      local iron = require("iron.core")
      local view = require("iron.view")

      iron.setup({
        config = {
          scratch_repl = true,
          repl_definition = {
            python = {
              command = function()
                if vim.fn.executable("ipython") == 1 then
                  return { "ipython", "--no-autoindent" }
                end
                return { "python3" }
              end,
            },
          },
          repl_open_cmd = view.split.vertical.botright(0.4),
        },
        keymaps = {
          send_line = "<leader>il",
          visual_send = "<leader>iv",
          send_until_cursor = "<leader>iu",
        },
        highlight = { italic = true },
        ignore_blank_lines = true,
      })

      vim.keymap.set("n", "<leader>ii", "<cmd>IronRepl<cr>", { desc = "Open/focus REPL" })
      vim.keymap.set("n", "<leader>ic", "<cmd>IronClose<cr>", { desc = "Close REPL" })
    end,
  },
}
