#!/usr/bin/env bash
# Run the same security checks as the CI pipeline, locally, using Docker only (no tool installs).
# Usage: ./scripts/scan-local.sh
set -uo pipefail
cd "$(dirname "$0")/.."
fail=0

echo "== 1/6 Secrets (Gitleaks) =="
docker run --rm -v "$PWD:/repo" zricethezav/gitleaks:latest detect --source /repo --config /repo/.gitleaks.toml --no-git --verbose || fail=1

echo "== 2/6 SAST (Semgrep) =="
docker run --rm -v "$PWD:/src" semgrep/semgrep semgrep scan \
  --config p/python --config p/owasp-top-ten --config semgrep/custom-rules.yml --error --severity ERROR /src || fail=1

echo "== 3/6 SCA (Trivy filesystem) =="
docker run --rm -v "$PWD:/src" aquasec/trivy fs --scanners vuln,secret --severity HIGH,CRITICAL --ignore-unfixed --exit-code 1 /src || fail=1

echo "== 4/6 IaC (Checkov, report only) =="
docker run --rm -v "$PWD:/tf" bridgecrew/checkov -d /tf --framework terraform kubernetes dockerfile --compact --quiet || true

echo "== 5/6 Policy as code (Conftest) =="
docker run --rm -v "$PWD:/project" openpolicyagent/conftest test \
  docker-compose.yml docker-compose.monitoring.yml k8s/namespace.yaml k8s/postgres.yaml k8s/odoo.yaml k8s/networkpolicy.yaml \
  --policy policy || fail=1

echo "== 6/6 Container image (Trivy) =="
if docker image inspect devsecops-odoo-lab:local > /dev/null 2>&1; then
  docker run --rm -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image \
    --severity CRITICAL --ignore-unfixed --exit-code 1 devsecops-odoo-lab:local || fail=1
else
  echo "Image not built yet. Run: docker compose build odoo"
fi

if [ "$fail" -ne 0 ]; then echo "RESULT: quality gate FAILED"; exit 1; fi
echo "RESULT: quality gate passed"
