# Subagents (user lanes)

Use this file for **when and how** to spawn subagents. Keep general behavior in `AGENTS.md`.

User-defined agents live in `~/.grok/agents/` and appear as `subagent_type` values. Bundled types (`explore`, `plan`, `general-purpose`) stay available for ad-hoc work without a full packet.

## When to delegate

For `MODERATE+` work, prefer a **named user lane** when the work is separable:

| Lane | `subagent_type` | Access | Use for |
|------|-----------------|--------|---------|
| Codebase map / impact | `codebase-researcher` | read-only | Multi-module mapping, traces, impact surface |
| External / version facts | `web-researcher` | read-only | Docs, APIs, freshness-sensitive facts |
| Bounded edits | `implementer` | write (scoped) | Owned file set, clear criteria |
| Tests | `tester` | write tests | TDD or verification matrix |
| Independent review | `reviewer` | read-only | Significant multi-file, security, policy, hooks, public API |

**Bundled types** (no packet required):

- `explore` — quick/ad-hoc codebase search
- `plan` — implementation planning
- `general-purpose` — catch-all multi-step work

Skip named lanes when: TRIVIAL/SIMPLE and local is faster; no separable lane; tight user Q&A; user refused; or spawn cost exceeds benefit. Report the skip reason when review would normally be mandatory.

## Mandatory delegation packet (named user agents)

Grok does **not** inject packets. Put the full packet in `spawn_subagent` **`prompt`**. Named user agents must **block** if the packet is incomplete.

```
OVERALL_GOAL: <one sentence>
WHY_THIS_MATTERS: <why this lane exists for the parent>
DESIRED_END_STATE: <observable done state>
LANE: codebase-researcher | web-researcher | implementer | tester | reviewer
SCOPE: <paths / symbols / behaviors in>
OUT_OF_SCOPE: <explicit non-goals>
CRITERIA:
- C1: <binary, verifiable>
ANTI_CRITERIA:
- A1: <must not happen>   # or: none
CONSTRAINTS: <style, safety, rtk, write-set, MODE for tester, etc.>
CURRENT_EVIDENCE: <compact facts / paths; not raw memory dumps>
REQUIRED_VALIDATION: <what proof the parent expects>
EXPECTED_OUTPUT: <shape beyond the common envelope>
```

Rules for the parent:

- Assign only the C/A IDs this lane owns.
- Do not pass raw memory dumps or broad chat history.
- For `implementer`, list owned write paths in `SCOPE` / constraints.
- For `tester`, set `MODE: tdd` or `verification` (default verification).
- For `reviewer`, include changed paths and the criteria under review.
- Never spawn `reviewer` for typo-only/TRIVIAL work; do spawn for MODERATE+ multi-file, security, config, hooks, permissions, policy, or public API/schema changes.

## Expected child envelope

Named user agents return this **first**:

```
STATUS: done | blocked
TASK_NAME:
RECEIVED_C:
RECEIVED_A:
C_RESULTS:
- C1 | pass/fail/insufficient | evidence
A_RESULTS:
- A1 | checked/violated/not-checked | evidence
SCOPE_RESULT:
- actions and files touched, or none
BLOCKERS:
PARENT_HANDOFF:
```

Treat child output as **context, not proof**. Re-verify criteria-relevant claims against files, command output, tests, or rendered artifacts before completion.

## Spawn hygiene

- Prefer `background: true` when the parent can continue other work; then collect with `get_command_or_subagent_output`.
- Prefer `capability_mode: read-only` when spawning research/review if the type is write-capable by mistake; named agent defs already set posture.
- Use `isolation: worktree` for experimental implementer work that must not touch the main tree.
- Subagents cannot nest; only the top-level session spawns.
- Never let two writers edit the same file concurrently; parallel implementers need disjoint write sets.
