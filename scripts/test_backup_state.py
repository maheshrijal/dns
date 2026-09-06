import os
import pathlib
import subprocess
import tempfile
import unittest

SCRIPT = pathlib.Path(__file__).with_name('backup-state.sh').resolve()


class BackupTests(unittest.TestCase):
    def run_backup(self, listing, phase='before', operation='import', failure=False):
        with tempfile.TemporaryDirectory() as directory:
            fake = pathlib.Path(directory) / 'aws'
            fake.write_text('#!/bin/sh\ncase "$*" in\n*list-objects-v2*)\n'
                            'if [ "$FAIL_LIST" = 1 ]; then exit 42; fi\n'
                            'printf "%s" "$LISTING";;\n'
                            '*copy-object*) echo "$*" > "$COPY_LOG";;\nesac\n')
            fake.chmod(0o755)
            log = pathlib.Path(directory) / 'copy.log'
            env = dict(os.environ, PATH=directory + os.pathsep + os.environ['PATH'],
                       LISTING=listing, FAIL_LIST='1' if failure else '0', COPY_LOG=str(log),
                       MIGRATION_OPERATION=operation, GITHUB_RUN_ID='123', GITHUB_RUN_ATTEMPT='1')
            result = subprocess.run(['bash', str(SCRIPT), 'mrjl.dev', phase], env=env,
                                    capture_output=True, text=True)
            return result.returncode, log.read_text() if log.exists() else ''

    def test_empty_bucket_allowed_only_before_first_import(self):
        self.assertEqual(self.run_backup('{}'), (0, ''))
        self.assertNotEqual(self.run_backup('{}', phase='after')[0], 0)
        self.assertNotEqual(self.run_backup('{}', operation='apply')[0], 0)

    def test_api_failure_never_treated_as_empty_state(self):
        self.assertNotEqual(self.run_backup('{}', failure=True)[0], 0)

    def test_only_exact_state_key_is_copied(self):
        code, copy = self.run_backup('{"Contents":[{"Key":"dns/mrjl.dev.tfstate"}]}')
        self.assertEqual(code, 0)
        self.assertIn('--copy-source tfstate/dns/mrjl.dev.tfstate', copy)
        self.assertIn('--key backups/mrjl.dev/', copy)
        self.assertEqual(self.run_backup('{"Contents":[{"Key":"dns/mrjl.dev.tfstate.tflock"}]}'), (0, ''))


if __name__ == '__main__':
    unittest.main()
