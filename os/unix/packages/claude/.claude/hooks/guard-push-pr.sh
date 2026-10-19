#!/bin/bash
# PreToolUse (Bash): before `git push` or `gh pr create`, require a valid approval.
# The approval is a marker in the git dir holding HEAD's SHA, written by
# code-reviewer-strict (APPROVED verdict) or /review-commit. If it is missing or stale
# (new commits since), it does NOT block: it asks for explicit human confirmation.

input=$(cat)
cmd=$(printf '%s' "$input" | jq -r '.tool_input.command // empty')
cwd=$(printf '%s' "$input" | jq -r '.cwd // empty')

case "$cmd" in
  *"git push"*|*"gh pr create"*) ;;
  *) exit 0 ;;
esac

[ -n "$cwd" ] || cwd="$PWD"
gitdir=$(git -C "$cwd" rev-parse --absolute-git-dir 2>/dev/null) || exit 0
head=$(git -C "$cwd" rev-parse HEAD 2>/dev/null) || exit 0
marker="$gitdir/claude-review-approved"

if [ -f "$marker" ] && [ "$(cat "$marker" 2>/dev/null)" = "$head" ]; then
  exit 0
fi

jq -n --arg r "No valid review approval for HEAD ${head:0:7} (missing APPROVED from code-reviewer-strict or /review-commit, or new commits since). Approve only if you reviewed it yourself." '{
  hookSpecificOutput: {
    hookEventName: "PreToolUse",
    permissionDecision: "ask",
    permissionDecisionReason: $r
  }
}'
