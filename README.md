# DevSecOps Odoo Lab

A hands-on DevSecOps learning lab built around a self-hosted **Odoo Community** stack. It takes one
real application from `docker compose up` all the way to a signed image, infrastructure as code,
Kubernetes with admission control, and observability, with security checks at every stage.

> Learning lab. Do not use as-is in production, and keep real credentials and company data out of it.

## What is inside

| Area | Path | What you practise |
|---|---|---|
| Application | `docker-compose.yml`, `app/` | Hardened Compose stack, custom Odoo module with tests |
| CI/CD + security gates | `.github/workflows/` | Gitleaks, Semgrep, Trivy, Checkov, Conftest, ZAP, SBOM, Cosign |
| Custom rules | `semgrep/`, `policy/` | Odoo-specific SAST rules, OPA/Rego policy as code |
| Cloud IaC | `terraform/` | VPC, locked-down security group, IMDSv2, encrypted EC2, SSM |
| Configuration | `ansible/` | Host hardening (SSH, UFW, fail2ban, auditd) and deployment |
| Kubernetes | `k8s/` | Pod Security, NetworkPolicy, Kyverno policies |
| Observability | `docker-compose.monitoring.yml`, `monitoring/` | Prometheus, Grafana, Loki, Promtail |
| Learning path | `docs/` | Six phase guides, progress tracker, ISO 27001 mapping, report template |

## Quick start (local)

```bash
cp .env.example .env            # then edit the passwords
docker compose up -d --build
# open http://localhost:8069 and create a database
```

Stop any older Odoo compose stack that also uses port 8069 first (`docker compose down`, without `-v`
if you want to keep its data).

Run the same security checks as CI, using Docker only:

```bash
./scripts/scan-local.sh          # Linux / macOS / WSL
.\scripts\scan-local.ps1         # Windows PowerShell
```

Optional monitoring stack:

```bash
docker compose -f docker-compose.yml -f docker-compose.monitoring.yml up -d
```

## Learning path

Start with [`docs/00-roadmap.md`](docs/00-roadmap.md): it has the pipeline diagram and a checklist.

1. [Foundations](docs/01-foundations.md): Linux, Git, networking
2. [Containers and CI/CD](docs/02-containers-cicd.md)
3. [Security in the pipeline](docs/03-security-pipeline.md): the DevSecOps core
4. [IaC and cloud](docs/04-iac-cloud.md): Terraform, Ansible
5. [Kubernetes and runtime security](docs/05-kubernetes.md)
6. [Observability and compliance](docs/06-observability-compliance.md)

Supporting material: [ISO 27001 mapping](docs/iso27001-mapping.md),
[finding report template](docs/finding-report-template.md), [GitHub setup](docs/github-setup.md).

## Pipeline

```
Commit -> secrets -> SAST -> SCA -> IaC/policy -> build -> image scan + SBOM -> tests -> DAST -> publish + sign
```

Quality gates: Gitleaks, Semgrep (ERROR), Trivy (HIGH/CRITICAL on filesystem, CRITICAL on image) and
Conftest block the build. Checkov and the ZAP baseline start in report-only mode; turning them into
gates is a Phase 3/4 exercise.

## Status of this repository

The workflows, Terraform, Ansible and Kubernetes files were written as a starting point and have not
been executed against live services by their author. Expect to fix small things (tool versions, image
tags, base-image findings) on first run. That troubleshooting is part of the exercise; record what you
fix in your own commit history.

## License

MIT, see [LICENSE](LICENSE).
