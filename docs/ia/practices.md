# Claude Code — Token-Saving Habits

> Source: Juan Andrés Núñez Charro — "¿Cómo ahorrar tokens con Claude Code?"
> 10 cambios que vienen de la documentación, no del marketing.

---

## Hábito 1. Mira dónde se van los tokens

`/context` desglosa el uso por categoría: system prompt, tools, MCP tools, memory files, messages, free space.
Si no lo miras, no sabes qué apagar.

---

## Hábito 2. Limpia entre tareas

`/clear` al cambiar de tarea. El stale context se paga en cada mensaje siguiente.
`/rename` antes de limpiar para poder encontrar la sesión después con `/resume`.

---

## Hábito 3. Compacta con instrucciones

`/compact` no es solo "resume". Puedes decirle exactamente qué preservar.

```
/compact Focus on code samples and API usage
# CLAUDE.md
# Compact instructions
When you are using compact, please focus on test output and code changes
```

---

## Hábito 4. Sonnet por defecto. Opus solo para arquitectura

`/model` para cambiar al vuelo en mitad de una sesión.
Para subagentes simples, especifica `model: haiku` en su configuración — sale gratis comparado con Sonnet.

> Docs: "Sonnet handles most coding tasks well and costs less than Opus. Reserve Opus for complex architectural decisions or multi-step reasoning."

---

## Hábito 5. `/mcp` y CLI tools nativas

`/mcp` para ver y desactivar servers que no usas. Cada server activo deja sus tool names en el contexto, aunque las definiciones estén deferred.
Prefiere `gh`, `aws`, `gcloud`, `sentry-cli` antes que MCP servers — las CLI tools no añaden ni siquiera el listing.

> Docs: "MCP tool definitions are deferred by default, so only tool names enter context until Claude uses a specific tool."

---

## Hábito 6. Preprocesa con hooks

Un `PreToolUse` hook intercepta el comando antes de ejecutarlo y puede reescribirlo via `updatedInput`.
Convierte 10.000 líneas de test output en las 50 que importan — Claude solo ve el output filtrado, el resto nunca entra al contexto.

**Hook canónico de la docs:**
```bash
#!/bin/bash
input=$(cat)
cmd=$(echo "$input" | jq -r '.tool_input.command')

if [[ "$cmd" =~ ^(npm test|pytest|go test) ]]; then
  filtered="$cmd 2>&1 | grep -A 5 -E 'FAIL|ERROR' | head -100"
  cat <<EOF
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "allow",
    "updatedInput": {"command": "$filtered"}
  }
}
EOF
fi
```

---

## Hábito 7. CLAUDE.md a Skills

`CLAUDE.md` se carga al inicio de la sesión — esos tokens están en tu contexto desde el primer turno hasta el último.
Skills cargan on-demand — tokens solo si se invoca.

Mueve todo lo específico de un workflow a una Skill.
Objetivo de la docs: **CLAUDE.md por debajo de 200 líneas**.

| Archivo | Comportamiento |
|---------|---------------|
| `CLAUDE.md` | Cargado al inicio → tokens en cada mensaje |
| `Skill` | Cargado on-demand → tokens solo si se invoca |

---

## Hábito 8. Baja el thinking en tareas simples

Los thinking tokens se facturan como output. El budget por defecto puede ser decenas de miles de tokens por request.

`/effort low` o `/effort minimal` cuando no haces razonamiento profundo.
`MAX_THINKING_TOKENS=8000` para topar el budget global desde el environment.

---

## Hábito 9. Delega lo verboso a subagentes

`npm test`, `gh pr view`, `tail -f logs/*.log` — todo eso quema contexto en tu conversación principal.

Delega via Task tool → el output verboso queda en el contexto del subagente, solo el resumen vuelve a tu conversación.

> Docs: "The verbose output stays in the subagent's context while only a summary returns to your main conversation."

---

## Hábito 10. Plan mode antes de implementar

`Shift+Tab` entra en plan mode. Claude explora el codebase y propone un approach **antes** de tocar nada.

Si la dirección inicial es la equivocada, lo descubres en plan mode (barato) en vez de a mitad de implementación (caro y con re-trabajo).

> Docs: "Preventing expensive re-work when the initial direction is wrong."
