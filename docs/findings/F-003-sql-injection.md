# Finding Report Template

Copy one block per finding. Keep wording factual and reproducible.

```
ID:            F-003
Title:         SQL injection pattern in Odoo model method (simulation)
Detected by:   Semgrep custom rule semgrep.odoo-sql-injection-string-building (pipeline job sast)
Severity:      Error (rule severity); Info in practice, because the method was written for the simulation and is never called
CWE / OWASP:   CWE-89 / A03:2021 Injection
Location:      app/addons/devsecops_demo/models/demo_note.py:18 (pull request #13, closed without merging)
Description:   A model method built a SQL statement by string formatting and passed it to cr.execute(), so user input could change the query.
Evidence:      SAST (Semgrep) failed with 1 blocking finding at line 18; the Build, test, image scan, DAST job was skipped and the merge button stayed locked. Details are in the semgrep.sarif artifact of run <tautan run merah>.
Impact:        An attacker who controls the name argument could read or alter other rows, for example by injecting a condition that is always true.
Remediation:   Use a parameterised query: cr.execute("SELECT id FROM devsecops_demo_note WHERE name = %s", (name,)). Commit 56183c8 on the pull request branch.
Status:        Detected and fixed on the branch (simulation); not merged
Verified by:   <tautan run hijau #35>
Lessons:       The first commit had a syntax error (a missing closing bracket). Semgrep passed without analysing the file, while the Build job failed because Odoo could not load the module. A green scan does not prove the code is safe: check the "Parsed lines" figure in the Semgrep summary and make sure the code at least compiles.
```

## Triage workflow
1. Reproduce or confirm the finding.
2. Rate severity using exploitability and exposure, not the scanner label alone.
3. Fix, or accept with an owner and a review date.
4. Re-run the pipeline and attach the passing run as proof.
