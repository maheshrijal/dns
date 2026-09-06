import copy
import importlib.util
import pathlib
import unittest

spec = importlib.util.spec_from_file_location('review', pathlib.Path(__file__).with_name('review-plan.py'))
review = importlib.util.module_from_spec(spec)
spec.loader.exec_module(review)


class PlanApprovalTests(unittest.TestCase):
    def setUp(self):
        self.plan = {'resource_changes': [{'change': {'actions': ['no-op'], 'importing': {'id': 'zone/record'}}}]}

    def test_import_only_accepts_expected_count(self):
        review.check_import(self.plan, 1)
        with self.assertRaises(ValueError):
            review.check_import(self.plan, 2)

    def test_import_rejects_every_mutation(self):
        for actions in [['create'], ['update'], ['delete'], ['delete', 'create']]:
            changed = copy.deepcopy(self.plan)
            changed['resource_changes'][0]['change']['actions'] = actions
            with self.assertRaises(ValueError):
                review.check_import(changed, 1)

    def test_approval_covers_commit_values_and_drift_but_not_timestamp(self):
        original = review.fingerprint(self.plan, 'commit-a')
        self.assertNotEqual(original, review.fingerprint(self.plan, 'commit-b'))
        self.assertEqual(original, review.fingerprint(dict(self.plan, timestamp='later'), 'commit-a'))
        for key in ['planned_values', 'resource_changes', 'resource_drift', 'output_changes']:
            changed = dict(self.plan, **{key: {'changed': True}})
            self.assertNotEqual(original, review.fingerprint(changed, 'commit-a'))


if __name__ == '__main__':
    unittest.main()
