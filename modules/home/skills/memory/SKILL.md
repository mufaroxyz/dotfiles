---
name: memory
description: Use for explicit local project memory in `.opencode/memory.md` or explicitly global preferences in `~/.config/opencode/memory.md`.
---

# Local Memory

Use only explicit, local Markdown persistence:

- Store project facts and decisions in the current project's `.opencode/memory.md`.
- Store only explicitly global preferences in `~/.config/opencode/memory.md`.
- Check the selected file before adding anything, and deduplicate or update an existing entry instead of repeating it.
- Never store secrets, tokens, credentials, API keys, private keys, or personal sensitive data.
- Write memory only when the user explicitly asks to remember something or update memory. Reading and summarizing memory does not authorize changes.
- If the requested scope is unclear, ask whether it is project-local or global before writing.

Keep entries concise, durable, and factual. Do not create or modify any other memory store, external service, MCP server, or project file as part of this workflow.
