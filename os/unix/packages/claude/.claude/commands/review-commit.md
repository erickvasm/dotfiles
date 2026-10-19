---
model: sonnet
---
Review all pending git changes, apply quality fixes, commit with a compressed message, then ask for confirmation before pushing.

Use this for small and medium changes. Non-trivial features go through the dev + review agent chain (see CLAUDE.md), which already covers code and security review: do not repeat steps 2–3 on a change that `code-reviewer-strict` approved for the current HEAD.

## 1. Inspect changes
Run `git diff HEAD --stat` then `git diff HEAD`. Understand what changed before touching anything.

## 2. Code review
Use the Skill tool to invoke `code-review` with args `--effort high`.
Apply all correctness bugs it flags. Skip stylistic nits that don't affect correctness.

## 3. Security review
Use the Skill tool to invoke `security`.
Fix every finding before continuing.

## 4. Domain-specific checks
Apply each checklist that matches the changed files:
- API route files → use the Skill tool to invoke `api-patterns`
- React / Next.js files → use the Skill tool to invoke `vercel-react-best-practices`
- Bug with unclear root cause → use the Skill tool to invoke `systematic-debugging`

## 5. Fix issues
Apply all flagged fixes from steps 2–4. No refactors beyond what was flagged.

## 6. Verify
Run the project's typecheck, lint and tests (for JS/TS: `pnpm typecheck`, `pnpm lint`, `pnpm test`; otherwise the project's equivalents). Fix every failure before continuing and report the real result.

## 7. Stage and commit
Stage all relevant changed files with `git add <files>`.
Use the Skill tool to invoke `caveman:caveman-commit` — it outputs the commit message.
Run `git commit -m "<exact message from skill>"`.

## 8. Record approval
Only if steps 2–6 finished clean, record the review approval for the new HEAD (a hook checks it before `git push` / `gh pr create`):
`git rev-parse HEAD > "$(git rev-parse --absolute-git-dir)/claude-review-approved"`

## 9. Confirm and push
Show the commit hash, message, and changed files. Ask the user to confirm before pushing —
push is a human approval gate, not automatic.
If confirmed: run `git push` (or `git push -u origin HEAD` if branch has no upstream).
If the pre-push hook blocks the push, fix the reported issues and retry from step 6.
If declined: stop. Leave the commit local.
