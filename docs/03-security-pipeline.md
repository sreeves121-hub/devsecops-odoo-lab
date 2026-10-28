# Phase 3 - Security in the Pipeline (the DevSecOps core)

| Stage | Question it answers | Tool | Where |
|---|---|---|---|
| Secret scan | Did a credential get committed? | Gitleaks | `.gitleaks.toml`, workflow job `secrets-scan` |
| SAST | Is the code itself unsafe? | Semgrep | `semgrep/custom-rules.yml` |
| SCA | Do dependencies have known CVEs? | Trivy fs | job `sca` |
| IaC | Is the infrastructure misconfigured? | Checkov | job `iac-policy` |
| Policy as code | Do manifests meet our rules? | Conftest (OPA) | `policy/*.rego` |
| Image scan | Does the image ship vulnerable packages? | Trivy image | job `build-test-dast` |
| SBOM | What exactly is inside the image? | Trivy (CycloneDX) | artifact `security-evidence` |
| DAST | Is the running app exposed? | OWASP ZAP | job `build-test-dast` |
| Signing | Is this image really from our pipeline? | Cosign (keyless) | job `publish` |

Run everything locally first: `./scripts/scan-local.sh` (or `.\scripts\scan-local.ps1` on Windows).

## Break-the-pipeline exercises
Do each on its own branch, watch the gate fail, then fix it. Log each one with the [report template](finding-report-template.md).

1. **Secret:** add a file containing `ghp_` followed by 36 random letters and digits. Gitleaks must fail. Then remove it from history (`git rebase -i` / `git filter-repo`) and explain why rotating a leaked secret matters more than deleting it.
2. **SQL injection:** in `models/demo_note.py` add a method that calls `self.env.cr.execute("SELECT * FROM res_users WHERE login = '%s'" % login)`. Semgrep must fail. Fix with a parameterised query.
3. **Vulnerable dependency:** create `app/requirements.txt` with an old, vulnerable version of a package (look one up in the GitHub Advisory Database). Trivy must fail. Upgrade it.
4. **Container as root:** add `USER root` at the end of `app/Dockerfile`. Checkov and your own review should flag it. Revert and add a Conftest rule for it.
5. **Open firewall:** change the Terraform ingress to `0.0.0.0/0` on port 22 (the variable validation will also object - why?). Observe Checkov.
6. **Exposed port:** change the compose port to `"8069:8069"`. The Conftest policy must fail.

## Tune like a professional
- [ ] Suppress a false positive correctly: `# nosemgrep: rule-id  -- reason` or `.trivyignore` with an expiry date and a ticket reference.
- [ ] Decide your quality gate in writing (what blocks a build, what only warns) and record the reasoning.
- [ ] Turn the ZAP baseline into a gate: remove `-I` and add a rules file (`-c zap-rules.conf`).
- [ ] Verify the signature: `cosign verify --certificate-identity-regexp '.*' --certificate-oidc-issuer https://token.actions.githubusercontent.com ghcr.io/<you>/devsecops-odoo-lab@<digest>` (tighten the identity regex).
- [ ] Turn on GitHub secret scanning, push protection, Dependabot alerts and code scanning ([setup guide](github-setup.md)).

## Done when
You can show a failed build for each class of issue, the fix, and a short written justification of the gate.
