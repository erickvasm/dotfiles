#!/bin/bash
# PreToolUse (Bash): if the command is EXACTLY a simple test command, wrap it in
# test-runner.sh so only what matters (and the real exit code) reaches the context.
# Any other command (chained, piped, redirected, etc.) passes through untouched
# and is not auto-approved.

input=$(cat)
cmd=$(printf '%s' "$input" | jq -r '.tool_input.command // empty')
[ -z "$cmd" ] && exit 0

# Never touch multi-line commands.
case "$cmd" in
  *$'\n'*|*$'\r'*) exit 0 ;;
esac

# Pure test commands only: space-separated tokens, no ; & | < > ` $ ( ) { } \ '
safe_re='^(pnpm test|pnpm vitest run|pnpm turbo run test|npm test|npm run test|yarn test|npx vitest run|npx jest|vitest run|jest|pytest|go test|cargo test)( +[A-Za-z0-9_./:=@,"-]+)*$'
[[ "$cmd" =~ $safe_re ]] || exit 0

runner="$HOME/.claude/hooks/test-runner.sh"
[ -x "$runner" ] || exit 0

printf '%s' "$input" | jq --arg c "bash \"$runner\" $cmd" '{
  hookSpecificOutput: {
    hookEventName: "PreToolUse",
    permissionDecision: "allow",
    updatedInput: (.tool_input | .command = $c)
  }
}'
