#!/usr/bin/env bash
# Grok PreToolUse adapter for RTK (no official rtk init --grok yet).
# Deny bare shell commands that RTK can rewrite; allow already-prefixed commands.
set -u

if ! command -v rtk >/dev/null 2>&1; then
  exit 0
fi

if ! command -v jq >/dev/null 2>&1; then
  exit 0
fi

HOOK_PAYLOAD="$(cat)"
if ! printf '%s' "$HOOK_PAYLOAD" | jq -e . >/dev/null 2>&1; then
  exit 0
fi

COMMAND="$(printf '%s' "$HOOK_PAYLOAD" | jq -r '.toolInput.command // .tool_input.command // empty')"
if [[ -z "$COMMAND" ]]; then
  exit 0
fi

# Already going through RTK
if [[ "$COMMAND" =~ ^[[:space:]]*rtk($|[[:space:]]) ]]; then
  exit 0
fi

REWRITTEN="$(rtk rewrite "$COMMAND" 2>/dev/null || true)"
if [[ -z "$REWRITTEN" ]]; then
  REWRITTEN="$(rtk hook check "$COMMAND" 2>/dev/null || true)"
fi

# Trim whitespace
REWRITTEN="${REWRITTEN#"${REWRITTEN%%[![:space:]]*}"}"
REWRITTEN="${REWRITTEN%"${REWRITTEN##*[![:space:]]}"}"

if [[ -z "$REWRITTEN" || "$REWRITTEN" == "$COMMAND" ]]; then
  exit 0
fi

REASON="RTK enforcement: rerun this shell command through RTK to reduce token usage.
Command: ${COMMAND}
Suggested: ${REWRITTEN}"

jq -cn --arg reason "$REASON" '{decision:"deny",reason:$reason}'
exit 0
