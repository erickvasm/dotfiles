# CLAUDE.md — Global Agent Rules

Rules for any Claude agent across all projects. Stack-specific conventions live in `rules/` (loaded by file type) or in each project's own CLAUDE.md.

## General

- Read before editing. Never guess content.
- Prefer editing existing files over creating new ones; never create files outside the project without permission.
- Keep changes minimal and focused. No over-engineering, no abstractions or helpers for one-time operations, no planning for hypothetical requirements.
- Do not add comments, docstrings, or type annotations unless asked.
- Do not install new dependencies without asking first.
- When fixing bugs, find the root cause — no band-aids. Do not guess performance: measure first.
- If unsure between two options, pick one and explain the trade-off.
- Prefer simple, readable solutions over clever ones.

## Communication

- Be concise. Lead with action or answer, not reasoning.
- Do not repeat back what the user said — just do the work.
- Only ask for clarification when truly blocked. Make reasonable assumptions.
- Report errors and blockers immediately.

## Quality

- Check workflows in `.github/workflows` to know what CI enforces.
- No code with type errors, lint failures, or failing tests. Run linters/formatters before committing.
- Report real command output when claiming something passes.

## Security

- Never commit or expose secrets, tokens, credentials, or `.env` files.
- No destructive commands without confirmation (`rm -rf`, `git reset --hard`).
- Validate inputs at system boundaries only — trust internal code.
- Flag security issues in existing code immediately.
- Always verify current branch and status before committing or pushing.

## Tools

Before writing custom solutions, check what already exists: installed skills, MCP servers, `utilities/` and `os/unix/packages/bin/`.

- **Context7** (global): before writing code that calls any external library, confirm the current API there. Never rely on training-data assumptions.
- **Engram** (global plugin): persistent cross-session memory for the dev + review loop (round state, architecture decisions, resolved bugs).
- Other MCPs (Neon, Chrome DevTools, Cloudflare, GitHub, Postgres, etc.) are enabled per project. If one is needed and missing, say so instead of working around it.

## Skills

| Skill | When to invoke |
|---|---|
| `code-review` | Before any commit on non-trivial changes |
| `security` | Before any push touching auth, payments, or data access |
| `caveman:caveman-commit` | Every commit message — never write messages manually |
| `systematic-debugging` | Bug with unclear root cause after first read |

## Git Workflow

- Small changes: `/review-commit` reviews, fixes, verifies, commits (via `caveman:caveman-commit`), records approval, then asks for confirmation before pushing. Push is a human approval gate, never automatic.
- Commit convention: `feat:`, `fix:`, `docs:`, `chore:`, `refactor:`, `perf:`, `test:`, `style:`.
- One logical change per commit. Do not amend previous commits unless asked.
- Never force-push to `main` without explicit confirmation.
- PRs: clear, concise description, small and focused. If the change resolves an issue, the PR body includes `Closes #<n>` (or `Refs #<n>` if it doesn't fully close it).
- A hook asks for explicit human confirmation on `git push` / `gh pr create` when there is no review approval for the current HEAD.

<!-- FLUJO-DEV-REVIEW:START -->
## Dev + review flow

For non-trivial changes (new feature, refactor, API or data change):

0. **Spec + plan.** Before implementing, write a short spec in `specs/<slug>.md` (or in the issue): what and why, numbered verifiable acceptance criteria (AC1, AC2…), out of scope, and open questions. Then a brief technical plan (plan mode). Wait for the human to approve both. The `<slug>` is the same one used in `topic_key: "loop/<slug>"`. For small changes a 3–5 line spec is enough.
1. **Worktree.** The orchestrator creates an isolated worktree (`EnterWorktree`, or the Agent tool with `isolation: "worktree"`). Every agent in the chain works in that same worktree, never on `main`/`develop`. Each agent leaves its work in a local commit.
2. `task-developer` implements (basic TDD, SOLID, context7) and pastes the real typecheck/lint/test results.
3. `test-writer` strengthens coverage: edge cases, errors, regression. Every acceptance criterion must have at least one test that verifies it.
4. `code-reviewer-strict` re-runs typecheck/lint/tests on its own, verifies spec compliance criterion by criterion, audits code and security, and returns **APPROVED** or **CHANGES REQUESTED**. On APPROVED it writes the approval marker for HEAD.
5. On CHANGES REQUESTED go back to step 2 (or 3 if the gap is in the tests) and repeat step 4.
6. On APPROVED, `docs-sync` updates README/API docs/changelog.
7. Push the worktree branch and run `gh pr create` against `main`, always behind the human push gate. If the work comes from an issue, the PR body carries `Closes #<n>` or `Refs #<n>`.

Do not consider the task done without APPROVED. If the spec changes during implementation, update it in the same PR so it does not drift.

**Round cap:** at most 3 rounds of the 2→4 cycle. If there is no APPROVED after 3, stop the loop and report to the human. Hitting the cap is not an implicit approval.

**State between rounds:** `TaskCreate`/`TaskUpdate` for in-session progress; Engram `mem_save` with `topic_key: "loop/<slug>"` so state survives context compaction or a different session. Before resuming, run `mem_search`/`mem_context` on that `topic_key`.
<!-- FLUJO-DEV-REVIEW:END -->

<!-- LOOP-TRIGGERS:START -->
## Automation (Loop Triggers)

Repetitive processes (reviewing PRs, updating deps, fixing broken tests, triaging issues) are automated with `/schedule` (cron) or `/loop` (interval). Before creating a trigger: a specific goal (never open-ended), a defined stop condition, and a human gate before merge/push. No cron is active by default.
<!-- LOOP-TRIGGERS:END -->
