#!/usr/bin/env bash
# Runs once when the Codespace is created: install, build the web app, and load the demo businesses.
set -euo pipefail
cd "$(dirname "$0")/.."

pip install --user --quiet -r backend/requirements.txt
(cd frontend && npm ci --no-audit --no-fund && npm run build)

# Every Codespace gets its own demo password (or the one you set as a Codespaces secret named ARIAX_DEMO_PASSWORD).
PW="${ARIAX_DEMO_PASSWORD:-$(python -c 'import secrets; print(secrets.token_urlsafe(9))')}"
ARIAX_DEMO_PASSWORD="$PW" python scripts/seed_demo.py
printf 'Aria XAI demo login\n  username: admin\n  password: %s\n' "$PW" > "$HOME/aria-xai-login.txt"
chmod 600 "$HOME/aria-xai-login.txt"
