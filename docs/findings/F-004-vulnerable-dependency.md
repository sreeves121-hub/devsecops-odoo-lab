ID:            F-004

Title:         Vulnerable Python dependency detected in a pull request (simulation)

Detected by:   Trivy filesystem scan (pipeline job sca)

Severity:      High (Trivy rating: 4 findings, HIGH 4, CRITICAL 0); Info in practice, because the file was written for the simulation and the Dockerfile never installs it

CWE / OWASP:   <CWE dari halaman advisory> / A06:2021 Vulnerable and Outdated Components

Location:      app/requirements.txt (Twisted==26.4.0), pull request #<19>, closed without merging

Description:   The file pinned Twisted 26.4.0. Trivy reported four known vulnerabilities in that version: GHSA-vpp8-g58w-m8mp (HTTP/2 stream reset), CVE-2026-115775 (XML stream parser memory exhaustion), CVE-2026-115776 (unbounded IRC buffer) and CVE-2026-115778 (Telnet negotiation memory exhaustion). All are denial-of-service issues.

Evidence:      The SCA + secrets job failed with "Total: 4 (HIGH: 4, CRITICAL: 0)"; the Build, test, image scan, DAST job was skipped and the merge button stayed locked. Failing run: https://github.com/sreeves121-hub/devsecops-odoo-lab/actions/runs/42754667984.

Impact:        An application using this version could be knocked offline remotely, in some cases without authentication.

Remediation:   Upgrade to Twisted 26.10.0rc1 (the first fixed version). Applied on the pull request branch.

Status:        Detected and fixed on the branch (simulation); not merged

Verified by:   https://github.com/sreeves121-hub/devsecops-odoo-lab/actions/runs/42755202596

Lessons:       One pinned version carried four separate vulnerabilities, not just the advisory chosen for the exercise. The first fixed version is a release candidate, so in a real project the team must check whether a stable release exists and weigh the risk of running a pre-release. The gate only blocks HIGH and CRITICAL, so a Moderate advisory would pass unnoticed. Trivy scanned the manifest file even though nothing installs it, which shows scanners judge declared dependencies, not what actually runs.

