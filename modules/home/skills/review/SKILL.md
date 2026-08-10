---
name: review
description: Use for code review, diff review, pull request review, regression analysis, or pre-merge validation.
---

# Code Review

Review the actual diff and its callers, tests, configuration, and integration boundaries. Findings are the primary output.

- Order findings by severity and include exact file and line references.
- Report concrete bugs, regressions, security issues, data-loss risks, and missing tests; do not report stylistic preferences as defects.
- Trace changed behavior through error paths, edge cases, permissions, concurrency, and compatibility boundaries.
- Check whether tests exercise the changed behavior and identify the smallest valuable regression test.
- State assumptions and residual risks separately. If no findings exist, say so and name the remaining testing gaps.
