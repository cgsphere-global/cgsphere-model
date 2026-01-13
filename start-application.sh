#!/bin/bash
set -e
echo "Starting CG Sphere Model..."
cd /workspace
exec uvicorn application:app --host 0.0.0.0 --port 8000