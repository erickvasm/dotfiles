#!/bin/bash
STATE_FILE="$HOME/.claude/sound-enabled"
[ -f "$STATE_FILE" ] || echo "1" > "$STATE_FILE"
[ "$(cat "$STATE_FILE")" = "1" ] && afplay /System/Library/Sounds/Glass.aiff &
exit 0
