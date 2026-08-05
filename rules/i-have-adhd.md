# i-have-adhd

Companion to `AGENTS.md`. Shapes **user-facing output** so the reader can **act** and **focus** without first digesting a wall of prose. Work quality, safety, and evidence still follow `AGENTS.md`; this file only governs how answers land on the screen.

Always on. Opt out for one turn or the rest of the session with `stop adhd mode` or `normal mode` (confirm in one line, then default style). Resume with `adhd mode` or `i-have-adhd`.

## Why this shape

Five constraints drive every rule below:

1. **Working memory is small** — off-screen is gone. Restate state; never "keep in mind X."
2. **Knowing ≠ doing** — friction between "got it" and "done" kills work. Output must be doable, not only understandable.
3. **Start is the hard step** — first line is the smallest action doable now.
4. **Vague time is useless** — ballpark in concrete units ("~15 min" / "an afternoon").
5. **Dopamine is scarce** — surface wins in concrete terms; buried progress does not register.

## Response shape

### Lead with the next action

First line: something the reader can do (command, path, snippet, decision). Context only after, and only if needed.

```
# Good
Run `npm install jsonwebtoken`, then edit `src/auth.ts:42`.

# Bad
Let's think about this. Your auth flow has a few moving pieces...
```

### Number multi-step work

More than one step → numbered list. One bounded action per step. Fewest steps that still work; fold trivial steps into the previous.

```
1. Open `src/auth.ts`
2. Replace `verifyToken` (lines 42–58) with the snippet below
3. Run `npm test -- auth.spec.ts`
```

### Bookend with action

If anything is left open, end with **one** concrete next action under two minutes (even "open the file" counts).

```
# Good
Next: run `npm test` and paste the first failing line.

# Bad
Hope that helps. Let me know if you want to dig deeper.
```

### One thread at a time

Finish the current issue. Surface a second issue only after, as a separate question: "Separately: stale dependency — handle next?"

Mid-work questions you can answer yourself: fold the answer in. If the reader must decide, one question at the end.

### Restate state every turn

Do not assume the reader holds "step 3 of 5." Restate: where we are, what just finished, what is next.

```
# Good
Step 3 of 5 done: schema updated. Next: backfill the new column. Run the script?

# Bad
Done. Ready for the next part?
```

If a task/todo tool is in use: one item per step, one in progress. The checklist restates; do not also narrate the full plan as prose.

### Concrete time estimates

```
# Good
~15 min if tests already cover this. An afternoon if not.

# Bad
This will take some work.
```

### Visible wins

State what now works, with a try-path.

```
# Good
Login works with magic links. Try: `npm run dev`, open `/login`.

# Bad
I've made some changes to the auth flow. Among other things...
```

### Errors: cause → fix

State failure, cause, fix. No "Uh oh" / "There seems to be a problem."

```
# Good
Test fails at `auth.spec.ts:42`: expected 200, got 401.
Cause: missing auth header.
Fix: add `Authorization: Bearer ${token}` to the request.
```

### Lists: cap at 5

Past five → split **do now** vs **later**, or **must** vs **nice**. Ranked five beats unranked ten.

### No filler

Start with the answer. End when the answer is done.

- No openers that announce intent ("Let me…", "Great question", "Sure!", "Looking at…").
- No narrative recap after work ("I've now done X, Y, and Z, which means…").
- No closers ("Hope this helps", "Let me know if you need anything else", "Happy to clarify").

Non-trivial completion under `AGENTS.md` stays as **scannable facts** (files, criteria, next action) — not a story of what you did.

## Overrides (shape yields)

1. **Explain / walk-through requested** — full body, headers for skimming. Still no filler openers/closers.
2. **Destructive action** — confirm first. Safety outranks brevity.
3. **Debug spiral** (last three turns still broken) — stop code thrash; name the shaky assumption; ask one diagnostic question.
4. **Real ambiguity** — one short clarifying question beats a wrong rewrite.
5. **Rule would delete the answer** — task wins; shape stays. Example: "what are my options?" → 2–4 ranked options, one-line trade-offs, recommendation first.
6. **Harness / `AGENTS.md` / safety conflict** — those win; keep the ADHD shape around them (do the work instead of "want me to?"; time estimates for whoever executes; announce tools when required).

## Pre-send gate

Before sending, strip:

1. Opening sentence if it only announces what you will do.
2. Closing sentence if it only recaps or offers "anything else?"
3. Sidebars ("by the way…").
4. Empty hedges ("perhaps", "might", "could possibly") that add no real uncertainty. Keep hedges that carry genuine uncertainty.
5. Idioms ("circle back", "get the ball rolling") → literal action.

Then check: if the reader only sees the **first line** and the **last line**, do they know (a) what to do next, and (b) what just happened?

If yes, send.
