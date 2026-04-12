# CLAUDE.md — Project Rules

This file defines the baseline rules and conventions that Claude Code must follow
when working inside this dotfiles repository.

---

## General Rules

- Always read a file before editing it. Never guess content.
- Prefer editing existing files over creating new ones.
- Keep changes minimal and focused — do not over-engineer.
- Do not add comments, docstrings, or type annotations unless explicitly asked.
- Never commit secrets, credentials, or `.env` files.
- Use the commit style of this repo: `feat:`, `fix:`, `docs:`, `chore:`.
- Write concise commit messages that explain **why**, not just what.

Allways use pnpm for projects

## Stow Conventions

- All user-level configs live under `os/unix/packages/<pkg>/` and are symlinked to `$HOME` via GNU Stow.
- When adding a new config, create the correct directory structure mirroring `$HOME` inside the package folder.
- After modifying a stow package, remind the user to re-run `stow -v -t ~ <pkg>` if needed.

## MCP Servers

Always leverage the MCP servers installed in the project when they are relevant to the task:

| MCP | When to use |
|---|---|
| **GitHub MCP** | PRs, issues, repo operations — prefer over raw `gh` when available |
| **TestSprite MCP** | Generating and running tests |
| **Postgres MCP** | Database queries and schema operations |
| **Semgrep MCP** | Security scanning and static analysis |
| **Context7 MCP** | Fetching up-to-date library/framework documentation |
| **WebMCP (Google)** | Web search and browsing for research |

> If an MCP can handle the task, **use it first** before falling back to shell commands.

## Skills

Always check if an installed skill can handle the task before writing code from scratch.
Installed skills include but are not limited to:

- Frontend Design / Figma to Code
- Brand Guidelines / Interface Design
- Systematic Debugging
- Changelog Generator
- API Design Principles
- Error Handling Patterns
- React / Next Best Practices

> Run `/skills` or check the skills list to see all available skills before starting a task.

## Code Quality

- Run linters and formatters before committing when available.
- Prefer simple, readable solutions over clever ones.
- Do not install new dependencies without asking the user first.
- When fixing a bug, identify the root cause — do not apply band-aids.

## Safety

- Never force-push to `main` without explicit confirmation.
- Never run destructive commands (`rm -rf`, `git reset --hard`) without asking.
- Always verify the current branch and status before committing or pushing.
