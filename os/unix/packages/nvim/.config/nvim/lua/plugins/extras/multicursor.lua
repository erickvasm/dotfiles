-- MULTICURSOR — edita múltiples posiciones simultáneamente
--
-- FLUJO BÁSICO:
--   1. Posiciona cursor en palabra/línea inicial
--   2. Agrega cursors (ver atajos abajo)
--   3. Edita normal — todos los cursors aplican el cambio
--   4. <Esc> para limpiar cursors cuando termines
--
-- ATAJOS PRINCIPALES:
--   ↑ / ↓             → agrega cursor en línea arriba/abajo
--   <leader>↑ / ↓     → salta línea sin agregar cursor
--   <leader>n / N     → agrega cursor en siguiente/anterior match de palabra
--   <leader>s / S     → salta match sin agregar cursor (útil para excluir ocurrencias)
--   <C-LeftClick>     → agrega/quita cursor con mouse en posición exacta
--   <C-LeftDrag>      → arrastra para agregar cursors en rango
--   <C-q>             → activa/desactiva cursors (sin borrarlos)
--
-- CUANDO HAY MÚLTIPLES CURSORS (keymap layer):
--   ← / →             → cambia cuál es el cursor principal
--   <leader>x         → elimina el cursor principal
--   <Esc>             → si desactivados: reactiva | si activos: limpia todos
--
-- EJEMPLOS DE USO:
--   Renombrar variable en bloque: posiciona en var → <leader>n repetido → ciw → escribe nuevo nombre
--   Editar N líneas iguales:       posiciona → ↓ N veces → edita
--   Excluir ocurrencia:            <leader>n hasta match que no quieres → <leader>s → <leader>n continúa

return {
  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    config = function()
      local mc = require("multicursor-nvim")
      mc.setup()

      local set = vim.keymap.set

      -- ↑/↓ agrega cursor en línea contigua; <leader>+flecha la salta
      set({ "n", "x" }, "<up>", function()
        mc.lineAddCursor(-1)
      end)
      set({ "n", "x" }, "<down>", function()
        mc.lineAddCursor(1)
      end)
      set({ "n", "x" }, "<leader><up>", function()
        mc.lineSkipCursor(-1)
      end)
      set({ "n", "x" }, "<leader><down>", function()
        mc.lineSkipCursor(1)
      end)

      -- <leader>n/N agrega cursor en siguiente/anterior match; s/S lo salta
      set({ "n", "x" }, "<leader>n", function()
        mc.matchAddCursor(1)
      end)
      set({ "n", "x" }, "<leader>s", function()
        mc.matchSkipCursor(1)
      end)
      set({ "n", "x" }, "<leader>N", function()
        mc.matchAddCursor(-1)
      end)
      set({ "n", "x" }, "<leader>S", function()
        mc.matchSkipCursor(-1)
      end)

      -- Ctrl+Click agrega/quita cursor; drag selecciona rango de cursors
      set("n", "<c-leftmouse>", mc.handleMouse)
      set("n", "<c-leftdrag>", mc.handleMouseDrag)
      set("n", "<c-leftrelease>", mc.handleMouseRelease)

      -- <C-q> pausa todos los cursors sin borrarlos (útil para navegar)
      set({ "n", "x" }, "<c-q>", mc.toggleCursor)

      -- Layer activo solo cuando hay múltiples cursors
      mc.addKeymapLayer(function(layerSet)
        -- ←/→ cambia el cursor principal (el que muestra la posición actual)
        layerSet({ "n", "x" }, "<left>", mc.prevCursor)
        layerSet({ "n", "x" }, "<right>", mc.nextCursor)

        -- <leader>x elimina solo el cursor principal
        layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor)

        -- <Esc>: reactiva si pausados, limpia todos si activos
        layerSet("n", "<esc>", function()
          if not mc.cursorsEnabled() then
            mc.enableCursors()
          else
            mc.clearCursors()
          end
        end)
      end)

      local hl = vim.api.nvim_set_hl
      hl(0, "MultiCursorCursor", { reverse = true })
      hl(0, "MultiCursorVisual", { link = "Visual" })
      hl(0, "MultiCursorSign", { link = "SignColumn" })
      hl(0, "MultiCursorMatchPreview", { link = "Search" })
      hl(0, "MultiCursorDisabledCursor", { reverse = true })
      hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
      hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
    end,
  },
}
