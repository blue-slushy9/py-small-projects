#!/usr/bin/bash

# This script will go through each py* directory under py-small-projects and
# delete the .git directory so that I can add and push them to GitHub
for item in *; do
  echo "$item"
  first_three=${item:0:3}
  echo "$first_three"
  if [[ "$first_three" == "py-" ]]; then
    cd "$item"
    rm -rf .git
    cd ..
  fi
done

echo "All .git subdirectories have been deleted. Please try adding the files \
and pushing your changes now."

echo
