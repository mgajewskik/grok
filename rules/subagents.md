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
| Independent review | `reviewer` | read-only | **PASS-gate:** post-impl Spec + Standards, fresh context |

**Bundled types** (no packet required):

- `explore` — quick/ad-hoc codebase search
- `plan` — implementation planning
- `general-purpose` — catch-all multi-step work

Skip named lanes when (except **PASS-gate**): TRIVIAL/SIMPLE and local is faster; no separable lane; tight user Q&A; user refused; or spawn cost exceeds benefit. **PASS-gate** for `reviewer` after non-`TRIVIAL` implementation is mandatory (section below).

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
- Compact CURRENT_EVIDENCE only — no raw memory dumps or broad chat history.
- For `implementer`, list owned write paths in `SCOPE` / constraints.
- For `tester`, set `MODE: tdd` or `verification` (default verification).

### PASS-gate (`reviewer`) — single source for parent loop

Authoritative procedure for post-implementation review. `AGENTS.md` points here.

**When:** after non-`TRIVIAL` delivered implementation, before reporting done. Includes all `SIMPLE` that is not typo/formatting-only. Valid skip: `TRIVIAL` or explicit user waiver (state why).

**Steps (completion = `Decision: PASS` or valid skip):**

1. Spawn `reviewer` with a full packet: changed paths in SCOPE, exact CRITERIA and ANTI_CRITERIA, CURRENT_EVIDENCE (diff fixed-point or path list, tests run). Prefer fixed-point or explicit paths so the child sees the real surface.
2. Read the envelope. On `STATUS: blocked` → repair the packet → re-spawn (step 1).
3. On `Decision: FAIL` / `VERDICT: request-changes` / any `[BLOCKER]` → fix every blocker → re-spawn with packet updated (what changed, prior blockers addressed) → step 2.
4. On `Decision: PASS` / `VERDICT: approve` → **PASS-gate** closed. Report NOTES optionally; NOTES alone do not re-open the loop.
5. Stall: same blockers, no progress after two full fix+re-review cycles → stop and hand the stuck set to the user.

Use the `reviewer` agent for this gate (Spec + Standards + severity live in `agents/reviewer.md`). Use the `review` skill only when the user asks for a fixed-point branch/PR review since a ref.

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
