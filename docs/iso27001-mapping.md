# Pipeline controls mapped to ISO/IEC 27001:2022 Annex A

| Control in this lab | Annex A control | Evidence produced |
|---|---|---|
| Branch protection, pull-request review | 8.4 Access to source code; 8.32 Change management | Repository settings, merged PR history |
| Secure pipeline stages (this repo) | 8.25 Secure development life cycle | Workflow file, run logs |
| Semgrep rules, code review | 8.28 Secure coding | SARIF reports |
| SAST, SCA, DAST, tests | 8.29 Security testing in development and acceptance | `security-evidence` artifact, ZAP report |
| Trivy fs/image, Dependabot, SBOM | 8.8 Management of technical vulnerabilities | Scan output, SBOM, Dependabot PRs |
| Terraform, Ansible, Kubernetes manifests, Conftest | 8.9 Configuration management | Versioned IaC, policy results |
| Secret scanning, Vault, `.env` handling | 5.17 Authentication information; 8.24 Use of cryptography | Gitleaks results, secret-handling runbook |
| Separate CI, staging and production-like environments | 8.31 Separation of development, test and production | Environment definitions |
| Docker networks, NetworkPolicy, security groups | 8.20 Networks security; 8.22 Segregation of networks | Manifests, Terraform |
| Loki, Prometheus, Falco | 8.15 Logging; 8.16 Monitoring activities | Dashboards, alert history |
| Cosign signing, provenance | 8.30 Outsourced development / supply chain integrity (supporting) | Signatures, attestations |
| Cloud account and IAM design | 5.23 Information security for use of cloud services | IAM policies, Terraform |
| Application requirements in Odoo module access rules | 8.26 Application security requirements | `ir.model.access.csv` |

Use this as input for your Statement of Applicability: each row should link to a repository path or pipeline artifact that proves the control is operating.
