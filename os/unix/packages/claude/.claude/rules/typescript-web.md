---
paths:
  - "**/*.ts"
  - "**/*.tsx"
  - "**/*.astro"
  - "**/*.css"
---

# TypeScript / Web conventions

Loaded only when working with TS/TSX/Astro/CSS files. If a project defines a different convention in its own CLAUDE.md, that one wins.

## Stack
- Use **pnpm** for everything: install, add, dlx, dev, build.
- **TypeScript** mandatory, strict mode from the start. Avoid `any` and `unknown`; prefer type inference. If types are unclear, clarify before continuing.
- **Tailwind CSS** is the only styling solution. Don't duplicate Tailwind classes — extract a component.
- Icons: **tabler-icons** with explicit imports, no barrels.
- Prefer ESM and modern browser syntax.

## Organization
- Small components, single responsibility; composition over complex configuration.
- Shared code lives in `components/`, `layouts/`, `lib/`, `utils/`.
- Accessibility required: semantic HTML, ARIA, managed focus.

## Testing
- Check workflows in `.github/workflows`.
- Tests: `pnpm test` or `pnpm turbo run test --filter <project>`; Vitest: `pnpm vitest run -t "<test name>"`.
- After moving files: `pnpm lint`.

## Skills for this stack
| Skill | When |
|---|---|
| `api-patterns` | Any change to route handlers or API layer |
| `vercel-react-best-practices` | Any change to React/Next.js components or pages |
| `neon-postgres` | Any DB migration, query tuning, or schema change |
| `ui-ux-pro-max` | Any UI component or design work |
