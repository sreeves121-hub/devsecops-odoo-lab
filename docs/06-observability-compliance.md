# Phase 6 - Observability and Compliance as Code

**Goal:** see what is happening, alert on it, and produce audit evidence automatically.

## Run the stack
```bash
docker compose -f docker-compose.yml -f docker-compose.monitoring.yml up -d
```
Grafana: http://localhost:3000 (user `admin`, password from `GRAFANA_ADMIN_PASSWORD`). Prometheus: http://localhost:9090.
On Docker Desktop, cAdvisor and node-exporter show the Docker VM, and cAdvisor may report limited metrics.

## Labs
- [ ] Build a Grafana dashboard: container CPU/memory, restarts, and Postgres/Odoo uptime.
- [ ] In Grafana Explore (Loki), run `{container="odoo-lab-odoo-1"} |= "Login failed"` and generate failed logins on purpose. Build a panel and an alert rule for more than 5 failures in 5 minutes.
- [ ] Forward Falco alerts to Loki (Falcosidekick) and show them next to application logs.
- [ ] Add a new Conftest rule (for example: every Deployment must have a readiness probe), see it fail in CI, then fix it.
- [ ] Map every pipeline control to ISO 27001 Annex A in [iso27001-mapping.md](iso27001-mapping.md) and decide what evidence each produces.
- [ ] Define and track DevSecOps metrics: percentage of builds blocked by gates, mean time to remediate a Critical finding, number of suppressed findings with expired reviews.
- [ ] Write a one-page incident runbook: "Secret committed to the repository" (detect, revoke, rotate, purge history, lessons learned).

## Done when
A new auditor could open the repo and the pipeline artifacts and verify each control without asking you a question.
