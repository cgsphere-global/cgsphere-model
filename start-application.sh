#!/bin/bash
set -e
echo "Starting CG Sphere Model..."
exec uvicorn application:app --host 0.0.0.0 --port 8000 --log-level debug
