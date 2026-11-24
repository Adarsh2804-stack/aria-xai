#!/usr/bin/env bash
# Runs every time the Codespace starts: start Aria XAI on port 8700 and show the demo login.
cd "$(dirname "$0")/.."
pkill -f "uvicorn app.main:app" 2>/dev/null || true
nohup python -m uvicorn app.main:app --app-dir backend --host 0.0.0.0 --port 8700 > /tmp/aria-xai.log 2>&1 &
echo
echo "Aria XAI is starting on port 8700 (open it from the Ports tab)."
[ -f "$HOME/aria-xai-login.txt" ] && cat "$HOME/aria-xai-login.txt"
echo "Server log: /tmp/aria-xai.log"
