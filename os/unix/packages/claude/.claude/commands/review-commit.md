Review all pending git changes, apply quality fixes, commit with a compressed message, then ask for confirmation before pushing.

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

## 6. Typecheck
Run the project's typecheck: try `pnpm typecheck`, then `npm run typecheck`, then `tsc --noEmit`.
Fix all type errors before continuing.

## 7. Stage and commit
Stage all relevant changed files with `git add <files>`.
Use the Skill tool to invoke `caveman:caveman-commit` — it outputs the commit message.
Run `git commit -m "<exact message from skill>"`.

## 8. Confirm and push
Show the commit hash, message, and changed files. Ask the user to confirm before pushing —
push is a human approval gate, not automatic.
If confirmed: run `git push` (or `git push -u origin HEAD` if branch has no upstream).
If the pre-push hook blocks the push, fix the reported issues and retry from step 6.
If declined: stop. Leave the commit local.
