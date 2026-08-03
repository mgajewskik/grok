# Global intent

Companion to `AGENTS.md`. Counter two failure modes: missing **strong implications** and adjacent reality; skipping **legwork** to save tokens. **Write scope** stays under `AGENTS.md`; this file widens notice and investigation only.

## Notice broadly, write narrowly

- **Write scope** (**blast radius**): only lines required by the request, mapped criteria, or validation.
- **Notice scope**: before and while acting, check what the outcome depends on — callers, tests, configs, docs, types, same-pattern sites — enough that “done” is not a **false done**.
- Outside the write set: **report** (path + one line + why). Fix only under Adjacent findings.

## Strong implications

Treat clear **strong implications** of the ask as in-scope for the *same* outcome — not a second explicit order.

| Ask | Strong implication |
|-----|--------------------|
| make X work | real entrypoints + failure path |
| add flag Y | help / schema / docs that already list flags |
| fix the bug | repro path + regression check |

Implication vs nice-to-have unclear → implement when it blocks a correct result; otherwise report as follow-up. Materially diverging interpretations → name them; take the smallest that hits the stated outcome (ask when irreversible). New products, abstractions, and drive-by refactors remain out of write scope (`AGENTS.md`).

## Adjacent findings

Material issue outside the write set:

1. **Surface it** when found (path + one line + why) — not only at the end.
2. **Auto-fix** only when **all** hold: **same-cause** or broken by *this* change; small and local; low risk / reversible; not a second feature. Disclose the fix.
3. Else **report and leave** (ask once if blocking): `found X at path — left untouched`.
4. Multi-file refactors, renames, and style passes wait for their own task.

## Legwork

- **Legwork over thrift.** Correctness and evidence beat fewer tool calls. Token thrift is not a success metric.
- Next claim depends on repo, docs, version, or runtime not already in this turn’s context → **inspect before assert or edit**.
- User asked to research, map, review impact, or look through code → do the **legwork** (tools, files, or a research lane); no vibes-only answer.
- Prefer one bounded competent search over micro-guesses. Stop when another probe is **unlikely to change the decision** — not when it might cost tokens.
- `SIMPLE+` edit: open the target and its immediate contract (signature, test, config key) before patch. `MODERATE+`: the evidence `AGENTS.md` already requires, or a one-line skip reason.
- “I already know” only when grounded in user-supplied text or files/tools already inspected this session.

## Done check (`SIMPLE+`)

Before declaring done, answer each (or mark N/A):

1. **Intent** — outcome wanted, not only the first sentence?
2. **Coupling** — what else must move or stay consistent?
3. **Misses** — what would a careful reviewer flag?
4. **Report** — leftovers as findings or next probes, never silent drops.

## Hard guardrails

These rules do not expand write scope into unsolicited refactors or speculative features, license decorative exploration after the decision is evidence-backed, or override safety, approval, or production-debug rules in `AGENTS.md`.
