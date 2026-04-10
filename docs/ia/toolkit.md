# Skills, MCPs, Hooks & Resources

Reference sheet for Claude Code utilities: skills, MCP servers, hooks, and where to find more.

---

## Skills

Reusable prompt-driven capabilities you can add to Claude Code.

| Skill | Description |
|---|---|
| Frontend Design | UI/UX layout generation and component styling |
| Figma to Code | Convert Figma designs into production-ready code |
| Brand Guidelines | Generate or enforce brand identity (colors, typography, tone) |
| Interface Design | Design system patterns, accessibility, and responsive layouts |
| Brainstorming | Ideation sessions for features, naming, architecture |
| Systematic Debugging | Step-by-step root cause analysis and fix strategies |
| Changelog Generator | Auto-generate changelogs from commits or PRs |
| API Design Principles | RESTful / GraphQL schema design and best practices |
| Error Handling Patterns | Structured error handling, retries, and fallback strategies |
| React / Next Best Practices | Patterns for React and Next.js (SSR, RSC, routing, state) |

For Claude Desktop this skill is Useful: <https://github.com/blader/humanizer>

---

## MCP Servers

Model Context Protocol servers that extend Claude Code with external tool integrations.

| MCP Server | Description |
|---|---|
| GitHub MCP | Interact with GitHub repos, issues, PRs, and actions |
| TestSprite MCP | Automated test generation and coverage analysis |
| Postgres MCP | Query and manage PostgreSQL databases directly |
| Semgrep MCP | Static analysis and security scanning |
| Context7 MCP | Up-to-date library documentation and context |
| WebMCP (Google) | Web browsing and search capabilities |

---

## Hooks

Hooks are shell commands that run automatically in response to Claude Code events. Useful for enforcing workflows and automating repetitive steps.

**Common hook examples:**

- **Pre-commit lint** — Run linter/formatter before every commit.
- **Post-edit test** — Trigger related tests after a file is edited.
- **Notification hook** — Send a Slack/desktop notification when a long task finishes.
- **Auto-stage** — Automatically stage specific file types after edits.
- **PR template check** — Validate PR description matches a template before creation.
- **Security scan** — Run a quick security check before pushing code.

Hooks are configured in `settings.json` under the `hooks` key. See the official docs for the full schema.

---

## Resources & Downloads

| Resource | URL |
|---|---|
| Vercel `skills.sh` | <https://skills.sh> |
| AI Templates | <https://www.aitmpl.com/> |
| Claude Code Official Docs | <https://code.claude.com/docs/en/> |
