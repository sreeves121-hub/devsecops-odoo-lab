# Phase 4 - Infrastructure as Code and Cloud

**Goal:** create and harden the Odoo host reproducibly instead of clicking in a console.

## Cost and safety first
- Create an AWS account with MFA on the root user, then work as an IAM user or SSO role - never the root user.
- Set a **budget alert** (for example USD 10) before creating anything.
- A `t3.small` is not free-tier (roughly USD 15-20 per month if left running). Always `terraform destroy` when done.
- Use a personal account, never a company account, for this lab.

## Labs
- [ ] `cd terraform && cp terraform.tfvars.example terraform.tfvars` and fill in your IP (`/32`) and SSH public key.
- [ ] `terraform fmt`, `terraform init`, `terraform validate`, `terraform plan`, read the plan, then `apply`.
- [ ] Reach Odoo through the tunnel from `terraform output ssh_tunnel_command`. Nothing is exposed publicly.
- [ ] Configure the host with Ansible: copy `inventory.ini.example` and `group_vars/all.yml.example`, encrypt secrets with `ansible-vault`, then `ansible-playbook playbook.yml`.
- [ ] Run `sudo lynis audit system` on the host before and after the playbook; record both hardening scores in a finding.
- [ ] Run Checkov on `terraform/` and fix at least five findings (flow logs, EBS defaults, monitoring, and so on) or document why each is accepted.
- [ ] Replace SSH with SSM Session Manager and close port 22 entirely.
- [ ] Move Terraform state to a remote S3 backend with encryption and locking.
- [ ] `terraform destroy`. Confirm in the console that nothing is left.

## Done when
You can rebuild the environment from scratch in one command sequence and explain every security group rule.
