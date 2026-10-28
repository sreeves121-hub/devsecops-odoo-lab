# Publishing this repo to GitHub

## 1. Create and push
```bash
cd ~/dev/devsecops-odoo-lab        # keep it outside OneDrive
git init -b main
git add .
git status                         # confirm .env and *.tfvars are NOT listed
git commit -m "Initial DevSecOps lab"

# Option A: GitHub CLI
gh auth login
gh repo create devsecops-odoo-lab --public --source=. --push

# Option B: create an empty repo on github.com first, then
git remote add origin https://github.com/<your-user>/devsecops-odoo-lab.git
git push -u origin main
```
Authenticate with the GitHub CLI or a fine-grained personal access token. Never paste a token into a file in the repo.

## 2. Harden the repository (Settings)
- Code security: enable **secret scanning**, **push protection**, **Dependabot alerts and security updates**, and **code scanning** (upload the Semgrep SARIF as an exercise).
- Branches: protect `main`, require pull requests, require the pipeline checks, block force pushes.
- Actions -> General: set default workflow permissions to **read-only**; require approval for workflows from outside contributors.
- Enable two-factor authentication on your account and use signed commits.

## 3. Use a personal account for personal learning
Keep company data, hostnames, and credentials out of this repository entirely.
