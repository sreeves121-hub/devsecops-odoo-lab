# Phase 2 - Containers and CI/CD

**Goal:** build a reproducible image and automate build and test with GitHub Actions.

## Learn
- Dockerfile best practices: pinned base image, non-root user, `.dockerignore`, multi-stage builds, healthchecks
- Image layers and size; registries (GHCR)
- GitHub Actions: triggers, jobs, `needs`, secrets, environments, caching, OIDC

## Labs
- [ ] Push the repo and get `.github/workflows/devsecops-pipeline.yml` green. Read every step.
- [ ] Pin the Odoo base image by digest in `app/Dockerfile` (`docker buildx imagetools inspect odoo:18.0`).
- [ ] Add a second test to `app/addons/devsecops_demo/tests/` and watch the pipeline run it.
- [ ] Add a status badge to the README.
- [ ] Pin every third-party Action to a commit SHA (keep Dependabot updating them).
- [ ] Add caching and compare run times.
- [ ] Settings -> Branches: protect `main`, require pull requests and the pipeline checks.

## Done when
A pull request cannot merge unless build and tests pass, and you can explain every line of the workflow.
