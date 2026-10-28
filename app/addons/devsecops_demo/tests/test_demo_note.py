from odoo.tests.common import TransactionCase, tagged


@tagged("post_install", "-at_install")
class TestDemoNote(TransactionCase):
    def test_action_done(self):
        note = self.env["devsecops.demo.note"].create({"name": "pipeline test"})
        self.assertEqual(note.state, "draft")
        note.action_done()
        self.assertEqual(note.state, "done")
