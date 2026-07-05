# Command in Lazyvim

## Search and replace

For search/replace in multiple files, LazyVim includes spectre. Just press <leader>sr (s)earch & (r)eplace to open its ui.

## Actualizar LazyVim

- `<leader>l`: abrir Lazy plugin manager
- Dentro del UI presionar `U` para update todos los plugins
- O directo con `:Lazy update` en command mode

## Splits (dividir pantalla)

- `<leader>|`: split vertical (lado a lado)
- `<leader>-`: split horizontal (arriba/abajo)
- `ctrl+h/l/j/k`: navegar entre splits
- `opt+l`: aumentar ancho split / sidebar (alt+l)
- `opt+h`: reducir ancho split / sidebar (alt+h)
- `opt+k`: aumentar alto split (alt+k)
- `opt+j`: reducir alto split (alt+j)
- Nota: `opt+arrows` no funciona en macOS terminal (lo intercepta para word-jump), por eso se usa `opt+hjkl`
- Para Claude sidebar: funciona estando dentro del sidebar (terminal mode) sin necesidad de salir

## Other commands

- <leader> e : open sidebar / file explorer (Neo-tree)
- <TAB> to move to nex tab
- a, e, m, d: in file explorer to add, edit, move or delete a file
- <leader>uL: Toggle Relative Line Numbers
- <leader> space: to find a file
- gd: go to definition
- gD: go to declaration
- gI: go to implementation
- gy: got to type definition
- <leader> cm: to open mason
- <leader> ge: git explorer
- <leader> gg: git ui
- <leader>sw: word search
- <leader>sT: search TODO, FIXME, etc
- ctr + d: delete tab
- ctrl + /: open/close terminal (toggle)
- ctrl + /: también con `<leader>ft` o `<leader>fT` (nueva terminal)
- <leader>xx: open trouble toggle
- <leader>D: open database
- <leader>ac: toggle Claude Code sidebar
- <leader>af: focus Claude Code
- <leader>ar: resume Claude session
- <leader>ab: add current buffer to Claude context
- q: close second sidebar
- Redimensionar sidebar Claude: estando dentro del sidebar usar `opt+h` / `opt+l`

## Database (vim-dadbod-ui)

Plugin: `vim-dadbod` + `vim-dadbod-ui`. Abrir con `<leader>D`.

### Conectar una BD (ejemplo con Docker PostgreSQL)

Levantar contenedor:

```bash
docker run -d \
  --name lazyvim-db \
  -e POSTGRES_USER=dev \
  -e POSTGRES_PASSWORD=dev123 \
  -e POSTGRES_DB=testdb \
  -p 5432:5432 \
  postgres:16-alpine
```

Connection string para dadbod:

```
postgresql://dev:dev123@localhost:5432/testdb
```

### Agregar conexión en dadbod-ui

1. `<leader>D` → abre DBUI sidebar
2. Presionar `A` para agregar nueva conexión
3. Pegar connection string: `postgresql://dev:dev123@localhost:5432/testdb`
4. Enter → aparece en el sidebar

### Navegación dentro de DBUI

- `o` / `Enter`: expandir/abrir tabla o base de datos
- `R`: refresh conexión
- `d`: borrar conexión
- `q`: cerrar sidebar
- Al abrir tabla → se abre buffer con query `SELECT * FROM tabla LIMIT 200`

### Ejecutar queries

- Abrir un `.sql` buffer y escribir query
- `<leader>S`: ejecutar query seleccionada (visual) o línea actual
- `<leader>E`: ejecutar todo el buffer
- Resultado aparece en split horizontal

### Comandos directos (sin UI)

```vim
:DB postgresql://dev:dev123@localhost:5432/testdb SELECT * FROM users;
```

## Comandos básicos Vim

### Movimiento por palabras

- Option + Shift + Up/Down (Alt+Shift+Up/Down): Mover línea arriba en modo normal
- `w`: inicio de siguiente palabra
- `b`: inicio de palabra anterior
- `e`: final de palabra actual/siguiente
- `E`: final de palabra (ignora puntuación)
- `B`: inicio de palabra anterior (ignora puntuación)

### Inicio y fin de línea

- `0`: inicio de línea (columna 0)
- `^`: primer carácter no-vacío de la línea
- `$`: final de línea
- `I`: inicio de línea + entrar insert mode
- `A`: final de línea + entrar insert mode

### Ir a línea específica

- `:<número>`: ir a línea, ej. `:42`
- `<número>G`: igual, ej. `42G`
- `gg`: ir a primera línea
- `G`: ir a última línea

### Multicursor (plugin: jake-stewart/multicursor.nvim)

Agregar cursores por línea:

- `↑ / ↓`: agregar cursor arriba/abajo
- `<leader>↑ / <leader>↓`: saltar línea arriba/abajo (sin agregar cursor)

Agregar cursores por match de palabra (como `ctrl+d` VSCode):

- `<leader>n`: seleccionar siguiente ocurrencia hacia adelante
- `<leader>N`: seleccionar siguiente ocurrencia hacia atrás
- `<leader>s`: saltar ocurrencia actual, ir a siguiente
- `<leader>S`: saltar ocurrencia actual, ir a anterior

Mientras hay múltiples cursores activos:

- `← / →`: cambiar cuál cursor es el principal
- `<leader>x`: eliminar cursor actual
- `<Esc>`: si cursors activos → limpiarlos; si desactivados → reactivar

Otros:

- `ctrl+click` (mouse): agregar/quitar cursor en posición
- `ctrl+q`: toggle cursor en posición actual

### Yanky (historial de yanks)

- `p / P`: pegar (igual que siempre pero tracked)
- `<C-p>`: ciclar al yank anterior en el historial (después de pegar)
- `<C-n>`: ciclar al yank siguiente en el historial (después de pegar)
- `]p / [p`: pegar con indentación ajustada (abajo/arriba)
- `<leader>p`: abrir historial de yanks (picker)
