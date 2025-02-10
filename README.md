# Shell Script Race Condition Bug

This repository demonstrates a race condition bug in a bash script that increments a counter concurrently.  The script uses multiple background processes to increment a counter in a file, but due to race conditions, the final value may be less than expected (10).

The `bug.sh` file contains the buggy script, and `bugSolution.sh` provides a corrected version using a lock file to prevent race conditions.

## How to reproduce
1. Clone this repository.
2. Run `bash bug.sh`.  Observe that the final counter value is likely less than 10.
3. Run `bash bugSolution.sh`.  Observe that the final counter value is now correctly 10.

## Bug Explanation
The bug occurs because multiple processes try to read and update the counter simultaneously.  If two processes read the same value, both will write the same incremented value, leading to a lost update.

## Solution
The solution uses a lock file to ensure only one process can access and update the counter at a time.