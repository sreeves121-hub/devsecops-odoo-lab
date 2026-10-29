ID:            F-001
Title:         Absence of Anti-CSRF Tokens
Detected by:   OWASP ZAP (baseline scan, pipeline job build-test-dast)
Severity:      Medium (ZAP rating); residual risk assessed as Low because the form requires the Odoo master password
CWE / OWASP:   CWE-352 / A01:2021 Broken Access Control
Location:      http://localhost:8069/web/database/manager (form action /web/database/create)
Description:   The Odoo database manager form has no anti-CSRF token. A forged cross-site request could try to trigger database actions if the victim is in the right session.
Evidence:      <form role="form" action="/web/database/create" method="post"> in zap-report.html
Impact:        If the master password were known or guessable, an attacker could create or drop databases. The database manager should not be exposed in shared or production environments.
Remediation:   Set list_db = False in app/config/odoo.conf to disable the database manager. PR: https://github.com/sreeves121-hub/devsecops-odoo-lab/pull/7
Status:        Fixed
Verified by:   https://github.com/sreeves121-hub/devsecops-odoo-lab/actions/runs/<angka>
Retest:        2026-10-29, rebuilt image from main; http://localhost:8069/web/database/manager now answers "disabled by the administrator". ZAP report from pipeline run <angka> no longer lists the manager form.