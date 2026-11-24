#!/usr/bin/env bash
# Runs every time the Codespace starts: start Aria XAI on port 8700 and show the demo login.
# The app runs in its own session (setsid), so it keeps running after this start-up script ends.
cd "$(dirname "$0")/.."
pkill -f "uvicorn app.main:app" 2>/dev/null || true
setsid -f python -m uvicorn app.main:app --app-dir backend --host 0.0.0.0 --port 8700 > /tmp/aria-xai.log 2>&1 < /dev/null
for _ in $(seq 1 30); do curl -sf -o /dev/null localhost:8700/healthz && break; sleep 1; done
echo
if curl -sf -o /dev/null localhost:8700/healthz; then
  echo "Aria XAI is running on port 8700 (open it from the Ports tab)."
else
  echo "Aria XAI did not start; see /tmp/aria-xai.log"
fi
[ -f "$HOME/aria-xai-login.txt" ] && cat "$HOME/aria-xai-login.txt"
