#!/bin/bash
# PreToolUse hook: rewrites test commands to filter output before it enters context.
# Converts potentially 10,000+ lines of test output to the ~50 that matter.
#
# Intercepts: npm test, pytest, go test, yarn test, pnpm test, cargo test, jest, vitest

input=$(cat)
cmd=$(echo "$input" | jq -r '.tool_input.command // empty')

if [[ "$cmd" =~ ^(npm[[:space:]]test|yarn[[:space:]]test|pnpm[[:space:]]test|pytest|go[[:space:]]test|cargo[[:space:]]test|jest|vitest) ]]; then
  filtered="$cmd 2>&1 | grep -A 5 -E 'FAIL|ERROR|FAILED|Error|assert|panic' | head -100"
  printf '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"allow","updatedInput":{"command":"%s"}}}' \
    "$(echo "$filtered" | sed 's/"/\\"/g')"
fi
