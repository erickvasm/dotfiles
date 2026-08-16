Toggle si el sonido de notificacion de Claude Code esta prendido o apagado.

Corre este comando exacto y reporta su output al usuario:

    f=~/.claude/sound-enabled; v=$(cat "$f" 2>/dev/null || echo 1); [ "$v" = 1 ] && echo 0 > "$f" || echo 1 > "$f"; [ "$(cat "$f")" = 1 ] && echo "Sound notifications: ON" || echo "Sound notifications: OFF"
