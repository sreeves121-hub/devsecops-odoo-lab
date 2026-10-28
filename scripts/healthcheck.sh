#!/usr/bin/env bash
# Phase 1 practice script: quick health report for the local Odoo stack.
set -euo pipefail

echo "Containers:"
docker compose ps --format 'table {{.Name}}\t{{.Status}}'

echo
if curl -fs http://localhost:8069/web/health > /dev/null; then
  echo "Odoo health endpoint: OK"
else
  echo "Odoo health endpoint: FAILED"
  exit 1
fi
