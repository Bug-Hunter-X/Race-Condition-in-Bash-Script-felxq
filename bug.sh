#!/bin/bash

# This script demonstrates a race condition bug.

# Create a file with initial value 0
echo 0 > counter.txt

# Function to increment the counter
increment_counter() {
  local current_value=$(cat counter.txt)
  local new_value=$((current_value + 1))
  echo $new_value > counter.txt
}

# Run increment_counter concurrently 10 times
for i in {1..10}; do
  increment_counter &
done

# Wait for all background processes to finish
wait

# Print the final value of the counter
echo "Final counter value: $(cat counter.txt)"