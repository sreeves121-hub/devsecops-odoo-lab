# Windows PowerShell version of scan-local.sh (requires Docker Desktop running).
# Usage: .\scripts\scan-local.ps1
Set-Location (Join-Path $PSScriptRoot "..")
$fail = $false
$pwdPath = (Get-Location).Path

Write-Host "== 1/6 Secrets (Gitleaks) =="
docker run --rm -v "${pwdPath}:/repo" zricethezav/gitleaks:latest detect --source /repo --config /repo/.gitleaks.toml --no-git --verbose
if ($LASTEXITCODE -ne 0) { $fail = $true }

Write-Host "== 2/6 SAST (Semgrep) =="
docker run --rm -v "${pwdPath}:/src" semgrep/semgrep semgrep scan --config p/python --config p/owasp-top-ten --config semgrep/custom-rules.yml --error --severity ERROR /src
if ($LASTEXITCODE -ne 0) { $fail = $true }

Write-Host "== 3/6 SCA (Trivy filesystem) =="
docker run --rm -v "${pwdPath}:/src" aquasec/trivy fs --scanners vuln,secret --severity HIGH,CRITICAL --ignore-unfixed --exit-code 1 /src
if ($LASTEXITCODE -ne 0) { $fail = $true }

Write-Host "== 4/6 IaC (Checkov, report only) =="
docker run --rm -v "${pwdPath}:/tf" bridgecrew/checkov -d /tf --framework terraform kubernetes dockerfile --compact --quiet

Write-Host "== 5/6 Policy as code (Conftest) =="
docker run --rm -v "${pwdPath}:/project" openpolicyagent/conftest test docker-compose.yml docker-compose.monitoring.yml k8s/namespace.yaml k8s/postgres.yaml k8s/odoo.yaml k8s/networkpolicy.yaml --policy policy
if ($LASTEXITCODE -ne 0) { $fail = $true }

Write-Host "== 6/6 Container image (Trivy) =="
docker image inspect devsecops-odoo-lab:local *> $null
if ($LASTEXITCODE -eq 0) {
  docker run --rm -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image --severity CRITICAL --ignore-unfixed --exit-code 1 devsecops-odoo-lab:local
  if ($LASTEXITCODE -ne 0) { $fail = $true }
} else {
  Write-Host "Image not built yet. Run: docker compose build odoo"
}

if ($fail) { Write-Host "RESULT: quality gate FAILED"; exit 1 }
Write-Host "RESULT: quality gate passed"
