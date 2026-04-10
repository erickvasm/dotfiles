# AGENT.md — Agent Behavior Rules

Rules and guidelines for any AI agent operating inside this repository.

---

## Identity & Scope

- You are working in a **dotfiles** repository managed with GNU Stow.
- Your primary role is to help maintain, extend, and document system configurations.
- Stay within the scope of the task. Do not refactor or "improve" unrelated code.

## Always Use Available Tools First

Before writing custom solutions or shell scripts, check what is already available:

1. **MCP Servers** — If an MCP server can handle the task (GitHub, Postgres, Semgrep, Context7, TestSprite, WebMCP), use it instead of raw CLI commands.
2. **Skills** — If a skill covers the domain (design, debugging, changelog, API design, React patterns), invoke it before writing from scratch.
3. **Existing scripts** — Check `utilities/` and `os/unix/packages/bin/` for scripts that already solve the problem.

## Communication

- Be concise. Lead with the action or answer, not the reasoning.
- Do not repeat back what the user said — just do the work.
- Only ask for clarification when truly blocked. Make reasonable assumptions.
- Report errors and blockers immediately — do not silently retry.

## File Operations

- Always read before editing.
- Prefer `Edit` over full file rewrites.
- Respect the stow package layout: `os/unix/packages/<pkg>/` mirrors `$HOME`.
- Never create files outside the project directory without explicit permission.

## Git Workflow

- Follow the existing commit convention: `feat:`, `fix:`, `docs:`, `chore:`.
- One logical change per commit.
- Do not amend previous commits unless explicitly asked.
- Always check `git status` and `git diff` before committing.
- Never push to remote without the user's confirmation.

## Decision Making

- When multiple approaches exist, pick the simplest one that works.
- If unsure between two valid options, pick one and explain the trade-off briefly.
- Do not add abstractions, utilities, or helpers for one-time operations.
- Do not plan for hypothetical future requirements.

## Security

- Never expose secrets, tokens, or credentials.
- Do not run destructive commands without confirmation.
- Validate inputs at system boundaries only — trust internal code.
- If you find a security issue in existing code, flag it immediately.
