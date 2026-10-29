# Finding Report Template

Copy one block per finding. Keep wording factual and reproducible.

```
ID:            F-002
Title:         Hard-coded secret detected in pull request (simulation)
Detected by:   Gitleaks (job secrets-scan, RuleID <RuleID dari log Gitleaks>) and Trivy filesystem scan (job sca, rule github-pat)
Severity:      Critical (Trivy rating); Info in practice, because the value was fabricated for a simulation
CWE / OWASP:   CWE-798 / A07:2021 Identification and Authentication Failures
Location:      app/addons/devsecops_demo/fake_token.py:1 (pull request #11, closed without merging)
Description:   A fabricated value in GitHub personal access token format was committed on a branch to test the secret-scanning controls.
Evidence:      Both required checks failed (Secret scan (Gitleaks) and SCA + secrets (Trivy filesystem)). The Build, test, image scan, DAST job was skipped and the merge button stayed locked. GitHub push protection did not block the push, because the fabricated value is not a valid token.
Impact:        With a real credential, an attacker could use whatever the token authorises, even after the branch is deleted, because the secret stays in Git history and in clones and caches.
Remediation:   Revoke and rotate any real secret immediately; deleting the file or the branch is not enough. Keep secrets in environment variables or a secret manager.
Status:        Detected and blocked (simulation)
Verified by:   <tautan run pipeline yang merah>

## Triage workflow
1. Reproduce or confirm the finding.
2. Rate severity using exploitability and exposure, not the scanner label alone.
3. Fix, or accept with an owner and a review date.
4. Re-run the pipeline and attach the passing run as proof.
