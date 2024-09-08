#!/usr/bin/bash

user_and_repos=()

# mapfile is designed specifically for multi-line input, the -t switch tells it 
# to ignore newline characters in the input when adding elements to the array
mapfile -t user_and_repos < <(gh repo list -L 120 | awk '{print $1}')

# Something in this line seems to be broken
#read -ra user_and_repos <<< "$(gh repo list -L 120 | awk '{print $1}')"
#read -a user_and_repos <<< "$(gh repo list -L 120 | awk '{print $1}')"

for repo in "${user_and_repos[@]}"; do
  echo "$repo"
done

: <<'COMMENT'
# The below code works
array=()

n=0
while [ $n -lt 10 ]; do
  array+=("$n")
  ((n++))
done

# This prints all array elements on one line, separated by spaces
echo "${array[@]}"

# This prints all array elements line by line
for num in "${array[@]}"; do
  echo "$num"
done
COMMENT
