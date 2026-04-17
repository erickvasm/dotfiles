# AGENT.md — Project Rules & Agent Behavior

Rules, conventions, and guidelines for any AI agent operating in this dotfiles repository.

---

## Identity & Scope

- Dotfiles repository managed with GNU Stow.
- Primary role: maintain, extend, and document system configurations.
- Stay within scope. Do not refactor unrelated code.

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

## Stow Conventions

- User-level configs live under `os/unix/packages/<pkg>/`, symlinked to `$HOME` via GNU Stow.
- New configs: mirror `$HOME` structure inside the package folder.
- After modifying a stow package, remind user to re-run `stow -v -t ~ <pkg>` if needed.

## Project Conventions

- Use **pnpm** for everything: install, add, dlx, dev, build.
- **TypeScript** mandatory, strict mode from start.
- **Tailwind CSS** only styling solution.
- Icons: **tabler-icons** with explicit imports, no barrels.
- Prefer ESM and modern browser syntax.

## Project Creation

- Use **Astro** for new projects: `pnpm create astro@latest <name>`
- Add Tailwind via official Astro integration.
- Do not add dependencies until necessary.

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

1. **MCP Servers** — Use over raw CLI when relevant:

   | MCP | When to use |
   |---|---|
   | GitHub | PRs, issues, repo operations |
   | TestSprite | Generating and running tests |
   | Postgres | Database queries and schema |
   | Semgrep | Security scanning, static analysis |
   | Context7 | Up-to-date library docs |
   | WebMCP | Web search and research |

2. **Skills** — Check installed skills before writing from scratch.
3. **Existing scripts** — Check `utilities/` and `os/unix/packages/bin/`.

## File Operations

- Always read before editing.
- Prefer `Edit` over full file rewrites.
- Respect stow layout: `os/unix/packages/<pkg>/` mirrors `$HOME`.
- Never create files outside project directory without permission.

## Git Workflow

- Commit convention: `feat:`, `fix:`, `docs:`, `chore:`.
- One logical change per commit.
- Do not amend previous commits unless asked.
- Check `git status` and `git diff` before committing.
- Never push without user confirmation.
- Never force-push to `main` without explicit confirmation.
- PRs: `[<project>] Clear, concise description`. Keep PRs small and focused.
- Before commit: `pnpm lint` + `pnpm test`.
- Explain what changed, why, and how verified.

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
