#!/bin/bash
set -e

APP_NAME="cgsphere-model"
BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
VENV_PY="$BASE_DIR/venv/bin/python"
LOG_DIR="$BASE_DIR/logs"
LOG_FILE="$LOG_DIR/app.log"
PID_FILE="$LOG_DIR/app.pid"

mkdir -p "$LOG_DIR"

if [ -f "$PID_FILE" ] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
  echo "❌ $APP_NAME already running (PID $(cat "$PID_FILE"))"
  exit 1
fi

echo "🚀 Starting $APP_NAME in background using venv python..."

nohup "$VENV_PY" -m uvicorn application:app \
  --host 0.0.0.0 \
  --port 8000 \
  --log-level info \
  > "$LOG_FILE" 2>&1 &

echo $! > "$PID_FILE"

sleep 1

if kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
  echo "✅ Started successfully"
  echo "📄 Logs: $LOG_FILE"
  echo "🧠 PID: $(cat "$PID_FILE")"
else
  echo "❌ Failed to start. Check logs:"
  cat "$LOG_FILE"
  exit 1
fi
