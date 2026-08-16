# CLAUDE.md — Global Agent Rules

Rules and conventions for any Claude agent across all projects.

---

## General Rules

- Read before editing. Never guess content.
- Prefer editing existing files over creating new ones.
- Keep changes minimal and focused — no over-engineering.
- Do not add comments, docstrings, or type annotations unless asked.
- Never commit secrets, credentials, or `.env` files.

## Communication

- Be concise. Lead with action or answer, not reasoning.
- Do not repeat back what the user said — just do the work.
- Only ask for clarification when truly blocked. Make reasonable assumptions.
- Report errors and blockers immediately.

## Project Conventions

- Use **pnpm** for everything: install, add, dlx, dev, build.
- **TypeScript** mandatory, strict mode from start.
- **Tailwind CSS** only styling solution.
- Icons: **tabler-icons** with explicit imports, no barrels.
- Prefer ESM and modern browser syntax.

## Code Organization

- Small components, single responsibility.
- Prefer composition over complex configurations.
- Avoid premature abstractions.
- Shared code in: `components/`, `layouts/`, `lib/`, `utils/`.

## TypeScript

- Avoid `any` and `unknown`.
- Prefer type inference when possible.
- If types unclear, clarify before continuing.

## UI & Accessibility

- Do not duplicate Tailwind classes — extract component.
- Prioritize readability.
- Accessibility required: semantic HTML, ARIA, managed focus.

## Testing & Quality

- Check workflows in `.github/workflows`.
- Tests: `pnpm test` or `pnpm turbo run test --filter <project>`.
- Vitest: `pnpm vitest run -t "<test name>"`.
- After moving files: `pnpm lint`.
- No code with type errors, lint failures, or failing tests.
- Run linters/formatters before committing.
- Prefer simple, readable solutions over clever ones.
- Do not install new dependencies without asking first.
- When fixing bugs, find root cause — no band-aids.

## Performance

- Do not guess performance — measure.
- Instrument before optimizing.
- Validate small before scaling.

## Tools & MCP Servers

Before writing custom solutions, check what is already available:

**MCP Servers** — Use over raw CLI when relevant:

| MCP | When to use |
|---|---|
| GitHub | PRs, issues, repo operations |
| TestSprite | Generating and running tests |
| Postgres | Database queries and schema |
| Semgrep | Security scanning, static analysis |
| Context7 | Always consult before writing code that uses any library — gets current API docs, not training-data assumptions |
| WebMCP | Web search and research |
| Neon (`mcp__Neon__*`) | Neon serverless Postgres: branches, SQL queries, migrations, slow query analysis |
| Chrome DevTools (`mcp__chrome-devtools__*`) | Browser automation, screenshots, performance tracing, console/network inspection |
| Engram (`mcp__plugin_engram_engram__*`) | Memoria persistente cross-sesión: guardar/recuperar estado del ciclo dev+review, decisiones de arquitectura, bugs resueltos — sobrevive compactación de contexto y reinicios |

**Skills** — Check installed skills before writing from scratch.

**Existing scripts** — Check `utilities/` and `os/unix/packages/bin/`.

## Skills — When to Use

| Skill | When to invoke |
|---|---|
| `code-review` | Before any commit on non-trivial changes |
| `security` | Before any push touching auth, payments, or data access |
| `caveman:caveman-commit` | Every commit message — never write messages manually |
| `systematic-debugging` | Bug with unclear root cause after first read |
| `api-patterns` | Any change to route handlers or API layer |
| `vercel-react-best-practices` | Any change to React/Next.js components or pages |
| `neon-postgres` | Any DB migration, query tuning, or schema change |
| `ui-ux-pro-max` | Any UI component or design work |

Context7 rule: before writing code that calls any external library, use Context7 to confirm current API. Never rely on training-data assumptions for library APIs.

## File Operations

- Always read before editing.
- Prefer `Edit` over full file rewrites.
- Never create files outside project directory without permission.

## Git Workflow

- Run `/review-commit` for every commit — it reviews, fixes, commits (via `caveman:caveman-commit` skill), then asks for confirmation before pushing. Push is a human approval gate, never automatic.
- Commit convention: `feat:`, `fix:`, `docs:`, `chore:`, `refactor:`, `perf:`, `test:`, `style:`.
- One logical change per commit.
- Do not amend previous commits unless asked.
- Never force-push to `main` without explicit confirmation.
- PRs: `Clear, concise description`. Keep PRs small and focused. Si el cambio resuelve un
  issue, el body del PR debe incluir `Closes #<n>` (o `Refs #<n>` si no lo cierra del todo)
  para que GitHub los vincule automáticamente.

## Decision Making

- Pick simplest approach that works.
- If unsure between two options, pick one and explain trade-off.
- No abstractions or helpers for one-time operations.
- No planning for hypothetical future requirements.

## Security

- Never expose secrets, tokens, or credentials.
- No destructive commands without confirmation (`rm -rf`, `git reset --hard`).
- Validate inputs at system boundaries only — trust internal code.
- Flag security issues in existing code immediately.
- Always verify current branch and status before committing or pushing.

<!-- FLUJO-DEV-REVIEW:START -->
## Flujo dev + review

Para cambios no triviales que disparan esta cadena, `task-developer` trabaja en un
worktree aislado (Agent tool con `isolation: "worktree"`, o `EnterWorktree`/`ExitWorktree`)
— nunca directo sobre `main`/`develop`. El merge a la rama principal ocurre solo después
de APROBADO + el gate humano de push (sección "Git Workflow").

Para tareas de código no triviales, usa estos subagentes en cadena:

1. `task-developer` implementa (TDD básico, SOLID, context7 para APIs actuales).
2. `test-writer` refuerza cobertura: edge cases, errores, regresión.
3. `code-reviewer-strict` audita implementación y pruebas (bugs, seguridad, Clean Code/SOLID, diseño de API) y devuelve veredicto: APROBADO o CAMBIOS REQUERIDOS.
4. Si hay cambios requeridos, vuelve al paso 1 (o 2 si el hueco es de pruebas) y se repite el paso 3.
5. Con APROBADO, `docs-sync` actualiza README/API docs/changelog.
6. Push la rama del worktree (nunca `main` directo) y `gh pr create` contra `main`. Si el
   trabajo viene de un issue, el body del PR lleva `Closes #<n>` (o `Refs #<n>`) para
   vincularlo — ver "Git Workflow". El merge a `main` sigue bajo el gate humano de push.

No des la tarea por terminada sin el veredicto APROBADO.

**Tope de rondas:** máximo 3 rondas del ciclo 1→4. Si tras 3 rondas no hay APROBADO,
detené el ciclo y reportá al humano en vez de seguir reintentando — evita loops
infinitos. Un tope alcanzado no es una aprobación implícita.

**Estado entre rondas:** `TaskCreate`/`TaskUpdate` trackean progreso visible dentro de
la sesión actual. Para que el estado sobreviva compactación de contexto o una sesión
distinta (retomar el mismo task días después), `task-developer` guarda cada ronda con
`mcp__plugin_engram_engram__mem_save` usando `topic_key: "loop/<slug-de-la-tarea>"` (qué se intentó,
qué falló, qué queda pendiente — upsert automático por topic_key, no crea una fila
nueva por ronda). Antes de arrancar una ronda o retomar la tarea, corré
`mcp__plugin_engram_engram__mem_search` / `mcp__plugin_engram_engram__mem_context` sobre ese `topic_key` en vez de
arrancar de cero.
<!-- FLUJO-DEV-REVIEW:END -->

<!-- LOOP-TRIGGERS:START -->
## Automatización (Loop Triggers)

Procesos repetitivos (revisar PRs, actualizar deps, generar docs, corregir tests rotos,
clasificar Issues) se automatizan con las skills `/schedule` (cron) o `/loop` (intervalo),
respaldadas por las tools `scheduled-tasks`/`CronCreate`.

Regla antes de crear un trigger automático:
- Objetivo específico, nunca abierto (ej. "corregir tests rotos", no "mejorar el proyecto").
- Condición de parada definida (ver tope de rondas arriba).
- Gate humano antes de merge/push (ver "Git Workflow").

No hay ningún cron activo por defecto — se crea puntualmente cuando se identifica un
proceso repetitivo concreto.
<!-- LOOP-TRIGGERS:END -->
