# Phase 5 - Kubernetes and Runtime Security

**Goal:** run Odoo on Kubernetes with security controls at admission and at runtime.

## Setup
Use **k3d** (k3s inside Docker, enforces NetworkPolicy by default) on Docker Desktop.

```bash
k3d cluster create odoo-lab
docker compose build odoo
k3d image import devsecops-odoo-lab:local -c odoo-lab

kubectl apply -f k8s/namespace.yaml
kubectl -n odoo-lab create secret generic odoo-secrets \
  --from-literal=postgres-user=odoo \
  --from-literal=postgres-password="$(openssl rand -hex 16)" \
  --from-literal=odoo-master-password="$(openssl rand -hex 16)"
kubectl apply -f k8s/postgres.yaml -f k8s/odoo.yaml -f k8s/networkpolicy.yaml
kubectl -n odoo-lab port-forward svc/odoo 8069:8069
```

The secret is created imperatively on purpose: never commit it. Phase exercise: replace it with Sealed Secrets or External Secrets.

## Labs
- [ ] Get Odoo running and create a database through the port-forward.
- [ ] Verify Pod Security: try to deploy a privileged pod in `odoo-lab` and watch it get rejected or warned.
- [ ] Prove NetworkPolicy works: from a temporary pod in another namespace, `curl` Odoo and Postgres and confirm both fail.
- [ ] Verify the Odoo UID with `docker run --rm --entrypoint id devsecops-odoo-lab:local` and fix `runAsUser` if needed.
- [ ] Enable `readOnlyRootFilesystem: true` for Odoo using `emptyDir` mounts for `/tmp`.
- [ ] Install Kyverno (Helm), apply `k8s/kyverno/policies.yaml` in Audit mode, review the policy reports, then switch to Enforce.
- [ ] Install Falco (Helm) and trigger an alert (for example `kubectl exec` into the pod and read `/etc/shadow`). Note: Falco's driver may not work on Docker Desktop; if so, run it on the cloud VM from Phase 4.
- [ ] Put HashiCorp Vault (dev mode) behind the Odoo secret and read it with the Vault Agent or External Secrets.
- [ ] Optional: install the Trivy Operator and read the vulnerability reports it creates as Kubernetes objects.

## Certification path
CKA first (cluster operations), then CKS (security). The labs above map directly onto CKS topics.

## Done when
A privileged or root workload is blocked, a lateral-movement attempt fails, and a suspicious shell in a pod raises an alert.
