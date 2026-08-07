# Global Memory

> This file is automatically managed by Grok's memory system.
> You can also edit it manually — changes will be indexed on next session.

## Preferences

- After a grilling (`/grill-me` / grilling skill) session finishes resolving plan decisions, always call `exit_plan_mode` to present the complete plan in the plan UI — do not only paste the plan as chat markdown.
- Save agent result markdown files (research, plan, etc.) as `YYYY-MM-DD-<kebab-slug>.md` in appropriate directory.
- **PASS-gate:** After non-TRIVIAL implementation, auto-spawn `reviewer` and re-spawn until `Decision: PASS` before done. Authoritative loop: `rules/subagents.md` (PASS-gate); summary: `rules/AGENTS.md`; agent: `agents/reviewer.md`.
<!-- Add any cross-project preferences here -->
