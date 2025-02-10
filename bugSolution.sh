#!/bin/bash

# This script demonstrates a solution to the race condition bug using a lock file.

# Create a file with initial value 0
echo 0 > counter.txt

# Function to increment the counter using a lock file
increment_counter() {
  # Acquire lock
  flock -n 200 </tmp/counter.lock || exit 1
  local current_value=$(cat counter.txt)
  local new_value=$((current_value + 1))
  echo $new_value > counter.txt
  # Release lock
  flock -u 200 </tmp/counter.lock
}

# Run increment_counter concurrently 10 times
for i in {1..10}; do
  increment_counter &
done

# Wait for all background processes to finish
wait

# Print the final value of the counter
echo "Final counter value: $(cat counter.txt)"