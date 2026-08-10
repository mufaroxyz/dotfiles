---
name: handoff
description: Produce a precise handoff covering completed work, evidence, blockers, and the next action. Use when the user asks for a handoff or continuation summary.
---

# Handoff

Inspect the current diff, status, relevant test output, and unfinished work before writing a concise handoff that includes:

- objective and current state
- files changed and the reason for each
- checks run and their results
- decisions, assumptions, and known risks
- blockers or explicitly unverified areas
- the single best next action or command

Do not make code changes unless the user explicitly asks for them. Use any text following `$handoff` as the audience or focus.
