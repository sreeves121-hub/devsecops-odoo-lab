# Finding Report Template

Copy one block per finding. Keep wording factual and reproducible.

```
ID:            F-001
Title:         <short description>
Detected by:   <Gitleaks | Semgrep | Trivy | Checkov | ZAP | manual>
Severity:      <Critical | High | Medium | Low | Info>  (CVSS v3.1 vector if applicable)
CWE / OWASP:   <CWE-89 / A03:2021 Injection>
Location:      <file:line, image layer, resource name>
Description:   <what is wrong and why it matters>
Evidence:      <log excerpt, scan output, screenshot path>
Impact:        <what an attacker could do>
Remediation:   <exact fix, with link to the commit or pull request>
Status:        <Open | Fixed | Accepted risk (reason, owner, review date) | False positive (reason)>
Verified by:   <pipeline run URL that proves the fix>
```

## Triage workflow
1. Reproduce or confirm the finding.
2. Rate severity using exploitability and exposure, not the scanner label alone.
3. Fix, or accept with an owner and a review date.
4. Re-run the pipeline and attach the passing run as proof.
