# Neovim / LazyVim — Guía de comandos

Referencia completa de atajos personalizados, plugins y tips de esta config.

---

## Keymaps personalizados (`config/keymaps.lua`)

| Atajo | Modo | Acción |
|-------|------|--------|
| `<Tab>` | n | Siguiente buffer |
| `<C-q>` | n | Cerrar buffer actual (`bd`) |
| `<C-d>` | n | Cerrar buffer actual (`bd`) — alias |
| `<C-a>` | n | Seleccionar todo (`ggVG`) |
| `<C-v>` | n | Pegar desde clipboard del sistema (`"+p`) |
| `<C-x>` | n | Cortar al clipboard del sistema (`"+x`) |
| `<C-z>` | n | Deshacer (`u`) |
| `<A-S-Up>` | n | Mover línea arriba (`Option+Shift+↑`) |
| `<A-S-Down>` | n | Mover línea abajo (`Option+Shift+↓`) |

---

## Navegación general

| Atajo | Acción |
|-------|--------|
| `<leader>e` | Abrir/cerrar Neo-tree (sidebar de archivos) |
| `<leader><space>` | Buscar archivo (fuzzy finder) |
| `<leader>sr` | Search & Replace en múltiples archivos (Spectre) |
| `<leader>uL` | Toggle números de línea relativos |
| `ctrl+h/l/j/k` | Navegar entre splits |

### Splits

| Atajo | Acción |
|-------|--------|
| `<leader>\|` | Split vertical |
| `<leader>-` | Split horizontal |
| `Option+→` | Aumentar ancho del split |
| `Option+←` | Reducir ancho del split |
| `Option+↑` | Aumentar alto del split |
| `Option+↓` | Reducir alto del split |

### Sidebar / paneles edgy (Neo-tree, Trouble, terminal)

Resize con cursor **dentro del panel edgy**:

| Atajo | Acción |
|-------|--------|
| `=` | Aumentar ancho del panel |
| `-` | Reducir ancho del panel |
| `+` | Aumentar alto del panel |
| `_` | Reducir alto del panel |

> edgy.nvim ignora `:vertical resize` estándar. Solo funciona su propia API (`win:resize`). Los keymaps son buffer-local — solo activos con cursor dentro del panel edgy.

---

## Buffers

| Atajo | Acción |
|-------|--------|
| `<Tab>` | Siguiente buffer |
| `<C-q>` / `<C-d>` | Cerrar buffer actual |

---

## Neo-tree (explorador de archivos)

| Atajo | Acción |
|-------|--------|
| `<leader>e` | Toggle sidebar |
| `a` | Crear archivo/carpeta |
| `e` | Renombrar |
| `m` | Mover |
| `d` | Eliminar |

> **Comportamiento custom:** se cierra automáticamente al abrir un archivo. Muestra dotfiles y archivos ignorados por git.

---

## LSP

| Atajo | Acción |
|-------|--------|
| `gd` | Ir a definición |
| `gD` | Ir a declaración |
| `gI` | Ir a implementación |
| `gy` | Ir a definición de tipo |
| `<leader>cm` | Abrir Mason (gestión de LSPs) |

> `virtual_text` está **desactivado** — errores se ven con underline, no como texto inline. Ver diagnósticos con `<leader>xx` (Trouble).

---

## Trouble (diagnósticos)

| Atajo | Acción |
|-------|--------|
| `<leader>xx` | Toggle Trouble (lista de errores/warnings) |

---

## Terminal

| Atajo | Acción |
|-------|--------|
| `<leader>ft` | Nueva terminal flotante |
| `<leader>fT` | Nueva terminal en tab |

> `Ctrl+/` es el default de LazyVim pero Warp lo intercepta. Usar `:lua Snacks.terminal()` para diagnosticar si es issue de keymap o de terminal.

---

## Git

| Atajo | Acción |
|-------|--------|
| `<leader>ge` | Git explorer (Neo-tree git status) |
| `<leader>gg` | Git UI (Lazygit) |

---

## Búsqueda

| Atajo | Acción |
|-------|--------|
| `<leader>sw` | Buscar palabra bajo cursor |
| `<leader>sT` | Buscar TODO, FIXME, NOTE, etc. |
| `<leader>sr` | Search & Replace global (Spectre) |

---

## Claude Code (`plugins/extras/claude.lua`)

| Atajo | Modo | Acción |
|-------|------|--------|
| `<leader>ac` | n | Toggle sidebar Claude Code |
| `<leader>af` | n | Focus en sidebar Claude |
| `<leader>ar` | n | Resumir sesión (`--resume`) |
| `<leader>aC` | n | Continuar sesión (`--continue`) |
| `<leader>am` | n | Seleccionar modelo |
| `<leader>ab` | n | Agregar buffer actual al contexto |
| `<leader>as` | v | Enviar selección visual a Claude |
| `<leader>as` | n (en tree) | Agregar archivo desde Neo-tree al contexto |
| `<leader>aa` | n | Aceptar diff propuesto por Claude |
| `<leader>ad` | n | Rechazar diff propuesto por Claude |
| `q` | n | Cerrar sidebar |

> Redimensionar sidebar Claude: estando dentro del panel usar `=` / `-` (keymaps edgy).

---

## Multicursor (`plugins/extras/multicursor.lua`)

Plugin: `jake-stewart/multicursor.nvim`

### Flujo básico

1. Posiciona cursor en palabra/línea inicial
2. Agrega cursors (atajos abajo)
3. Edita normal — todos los cursors aplican el cambio
4. `<Esc>` para limpiar cuando termines

### Por línea

| Atajo | Acción |
|-------|--------|
| `↑` / `↓` | Agregar cursor arriba/abajo |
| `<leader>↑` / `<leader>↓` | Saltar línea sin agregar cursor |

### Por match de palabra (como `Ctrl+D` en VSCode)

| Atajo | Acción |
|-------|--------|
| `<leader>n` | Siguiente ocurrencia → agrega cursor |
| `<leader>N` | Ocurrencia anterior → agrega cursor |
| `<leader>s` | Saltar ocurrencia actual, ir a siguiente |
| `<leader>S` | Saltar ocurrencia actual, ir a anterior |

### Con múltiples cursors activos

| Atajo | Acción |
|-------|--------|
| `←` / `→` | Cambiar cursor principal |
| `<leader>x` | Eliminar cursor principal |
| `<Esc>` | Activos → limpiar todos; pausados → reactivar |
| `<C-q>` | Pausar/reactivar todos los cursors |
| `Ctrl+Click` | Agregar/quitar cursor con mouse |
| `Ctrl+Drag` | Rango de cursors con mouse |

### Ejemplos

```
Renombrar variable:  posiciona en var → <leader>n (repetir) → ciw → escribe nuevo nombre
Editar N líneas:     posiciona → ↓ N veces → edita
Excluir ocurrencia:  <leader>n hasta match no deseado → <leader>s → <leader>n continúa
```

---

## Yanky (historial de yanks)

| Atajo | Acción |
|-------|--------|
| `p` / `P` | Pegar (trackeado en historial) |
| `<C-p>` | Ciclar al yank anterior (después de pegar) |
| `<C-n>` | Ciclar al yank siguiente (después de pegar) |
| `]p` / `[p` | Pegar con indentación ajustada |
| `<leader>p` | Abrir picker de historial de yanks |

---

## Movimiento Vim

### Por palabras

| Atajo | Acción |
|-------|--------|
| `w` | Inicio de siguiente palabra |
| `b` | Inicio de palabra anterior |
| `e` | Final de palabra actual |
| `E` | Final (ignora puntuación) |
| `B` | Inicio anterior (ignora puntuación) |

### Inicio/fin de línea

| Atajo | Acción |
|-------|--------|
| `0` | Inicio de línea |
| `^` | Primer carácter no-vacío |
| `$` | Final de línea |
| `I` | Inicio + insert mode |
| `A` | Final + insert mode |

### Ir a línea

| Atajo | Acción |
|-------|--------|
| `:<n>` | Ir a línea n (ej. `:42`) |
| `<n>G` | Ir a línea n (ej. `42G`) |
| `gg` | Primera línea |
| `G` | Última línea |

---

## Base de datos (`vim-dadbod-ui`)

Abrir con `<leader>D`.

### Setup con Docker PostgreSQL

```bash
docker run -d \
  --name lazyvim-db \
  -e POSTGRES_USER=dev \
  -e POSTGRES_PASSWORD=dev123 \
  -e POSTGRES_DB=testdb \
  -p 5432:5432 \
  postgres:16-alpine
```

Connection string: `postgresql://dev:dev123@localhost:5432/testdb`

### Navegación en DBUI

| Atajo | Acción |
|-------|--------|
| `A` | Agregar nueva conexión |
| `o` / `Enter` | Expandir/abrir tabla o BD |
| `R` | Refresh conexión |
| `d` | Borrar conexión |
| `q` | Cerrar sidebar |

### Ejecutar queries

| Atajo | Acción |
|-------|--------|
| `<leader>S` | Ejecutar query seleccionada o línea actual |
| `<leader>E` | Ejecutar todo el buffer |

```vim
" Sin UI:
:DB postgresql://dev:dev123@localhost:5432/testdb SELECT * FROM users;
```

---

## Gestión de plugins (Lazy)

| Atajo | Acción |
|-------|--------|
| `<leader>l` | Abrir Lazy plugin manager |
| `U` (en Lazy UI) | Actualizar todos los plugins |
| `:Lazy update` | Actualizar desde command mode |
