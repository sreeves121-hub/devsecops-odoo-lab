from odoo import fields, models


class DemoNote(models.Model):
    _name = "devsecops.demo.note"
    _description = "DevSecOps Demo Note"

    name = fields.Char(required=True)
    description = fields.Text()
    state = fields.Selection(
        [("draft", "Draft"), ("done", "Done")],
        default="draft",
    )

    def action_done(self):
        self.write({"state": "done"}
    def search_by_name(self, name):
        self.env.cr.execute("SELECT id FROM devsecops_demo_note WHERE name = '%s'" % name)
        return [row[0] for row in self.env.cr.fetchall()]
	
