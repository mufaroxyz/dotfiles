---
name: security-research
description: Use for security research, vulnerability audits, exploitability analysis, threat-model validation, or safe pre-release security checks.
---

# Security Research

Run an exploitability-driven security review using native task/background support when available. If parallel task support is unavailable, perform the perspectives sequentially.

1. Define the target, attacker capability, trust boundaries, sensitive assets, and test constraints.
2. Inspect entry points, authentication and authorization, data isolation, injection, secrets, filesystem and subprocess use, dependency and configuration boundaries.
3. For each candidate, record affected file/function, attacker capability, concrete attack path, impact, CWE candidate, evidence, and a safe verification idea.
4. Reproduce strong candidates with local fixtures, toy inputs, dry runs, or static proof. Never run destructive exploits against real services or third-party systems.
5. Report only findings with a plausible attack path. Separate severity from CWE and explain why candidates were reproduced, falsified, or downgraded.

Use a final report with: verdict, scope and commands, findings ordered by severity, evidence and attack path, safe proof, minimal fix, regression check, rejected candidates, and residual risk.
