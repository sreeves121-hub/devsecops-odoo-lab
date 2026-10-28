# Phase 1 - Foundations

**Goal:** be comfortable in a Linux shell, Git, and basic networking, using the Odoo stack as the playground.

## Learn
- Linux: users and permissions, `systemd`, `journalctl`, `ss`, `curl`, `dig`, `grep/awk/sed`, `ssh`
- Git: branches, pull requests, rebase, `.gitignore`, signed commits
- Bash and Python scripting
- Networking: DNS, HTTP, TLS certificates, reverse proxies

## Labs
- [ ] Install WSL2 + Ubuntu. Move this repo **out of OneDrive** (for example `~/dev/devsecops-odoo-lab`) - sync clients can corrupt `.git`.
- [ ] Start the stack: `cp .env.example .env`, edit passwords, `docker compose up -d --build`.
- [ ] Read `docker-compose.yml` line by line and explain each key (networks, healthcheck, `cap_drop`, `no-new-privileges`).
- [ ] Extend `scripts/healthcheck.sh`: check Postgres readiness and print disk usage of the volumes.
- [ ] Create a branch, change something, open a pull request, merge. Enable SSH commit signing.
- [ ] Add an `nginx` or `caddy` service with a self-signed certificate in front of Odoo; add security headers (HSTS, `X-Content-Type-Options`, CSP). Set `proxy_mode = True` in `app/config/odoo.conf`.
- [ ] Use `openssl s_client` and `curl -v` to inspect the certificate chain.

## Done when
You can explain what happens between typing `https://localhost` and Odoo returning a page, and you can recover the stack from scratch using only the repo.
