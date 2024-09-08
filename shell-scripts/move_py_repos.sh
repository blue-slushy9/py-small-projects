#!/usr/bin/bash

# NOTE: this script was originally written in GNU bash, version 
# 3.2.57(1)-release (x86_64-apple-darwin21); however, due to issues trying to
# run that version of bash on other platforms, the script was updated to use
# GNU bash, version 5.2*-release (x86_64-pc-linux-gnu)

# NOTE:
# py_repos contains all Python repos in blue-slushy9's entire GitHub profile

# py_num_repos is the same as py_repos, except that the indexes of each repo are 
# added to the beginning of the repo name

# py_repos2 contains the numbered Python repos (acquired from py_num_repos) which
# should remain their own standalone projects

# py_repos3 is the same as py_repos2, except the numbers and the space before 'py-'
# have been removed

####################

# I have already run all of the code in this block comment
: <<'COMMENT'

# Define function that will split our <user-name/repo-name> strings in the 
# next step
function splitter() {
  # Allows function to access first argument that will be passed
  local input_string="$1"
  # IFS is a variable in bash that defines how the shell parses a string;
  # Set IFS to the delimiter '/'; split the input_string using read with 
  # -r (raw) and -a (array) options, then assign resulting array to the 
  # variable split_string;
  #echo "$input_string" | IFS="/" read -a split_string
  IFS="/" read -a split_string <<< "$input_string"
  # First element is 'blue-slushy9', second is everything after the delimiter 
  # ('/'), i.e. the repo name only; assign to variable
  local repo_name="${split_string[1]}"
  # echo is used in bash instead of return to pass a string back to the caller
  echo "${repo_name}"
  # In bash, we do not need to explicitly return the string---in fact, bash
  # only allows you to return numeric values, e.g. '0' to signal success
  #return 0
}

# TEST
# Call function and store output in variable
#repo_name=$(splitter "blue-slushy9/py-create-backups")
#echo "repo_name2: ${repo_name}"


# Create empty user_and_repos array
#declare -a user_and_repos
user_and_repos=() # alternative syntax

# Create empty repo_names array
#declare -a repo_names
repo_names=()

# mapfile is designed specifically for multi-line input, the -t switch tells it 
# to ignore newline characters in the input when adding elements to the array
mapfile -t user_and_repos < <(gh repo list -L 120 | awk '{print $1}') 

# Define function that will echo array elements line by line
function echo_array() {
  # ("$@") is used to capture all array elements being passed to function;
  # had previously tried "$1", but that only captures first element 
  local array=("$@")
  for element in "${array[@]}"; do
    echo "$element"
  done
}

# TEST
echo_array "${user_and_repos[@]}"

# Loop through the array of repos and run each string through splitter function
for repo in "${user_and_repos[@]}"; do
  repo=$(splitter "$repo")
  # read overwrites anything already in the array, ergo we append with '+='
  repo_names+=("$repo")
done

# TEST
# Add a blankline with -e switch and \n
echo -e "\nuser_and_repos: "
for repo in "${user_and_repos[@]}"; do
  echo "$repo"
done

echo -e "\nrepo_names: "
for repo in "${repo_names[@]}"; do
  echo "$repo"
done
# /TEST

# Define function for extracting the first three characters of the repo name,
# which we will use in the next step
function get_first_three() {
  # Allows function to access first argument that will be passed
  local repo_name="$1"
  # Slice string to leave only the first three characters, assign to variable
  local first_three=${repo_name:0:3}
  # Echo the variable back to the function call
  echo "${first_three}"
}  


# Declare empty array for storing Python repos, to be populated in next step
py_repos=()

# Now iterate over the array and append all of the Python repos to the array;
for repo in "${repo_names[@]}"; do
  # Call first_three function to extract first three characters of repo name
  first_three=$(get_first_three "$repo")
  # If the first three characters we just extracted are 'py-'...
  if [ "$first_three" == "py-" ]; then
    # Append the repo name to our array of Python repos
    py_repos+=("$repo")
  # End of if statement
  fi
# End of for loop
done  

#Blank line
echo

: <<'COMMENT'
# TEST
echo -e "\npy_repos:"
for repo in "${py_repos[@]}"; do
  echo "$repo"
done

# Out of those py_repos, a handful of them will remain their own standalone
# projects; the script will have to prompt to see which of those repos should 
# NOT be added to our consolidated repo

# Declare array that will store the repo names with index numbers
py_num_repos=()

# Define for loop that will create an array of all Python repos in a numbered 
# list format
for ((n=0; n<${#py_repos[@]}; n++)); do
  # This variable will store the repo name preceded by its index
  num_repo="$n ${py_repos[$n]}"
  py_num_repos+=("$num_repo")
done

echo -e "This is the numbered list of Python repos, please look through it and \
make a note of which projects you would like to remain their own standalone \
repos:\n"

# Call echo_array function to list contents of py_num_repos line by line
echo_array "${py_num_repos[@]}"

# Blank line
echo


# Create a while loop that will iterate for as long as user continues to enter
# input into the terminal, i.e. repo names; once they have entered all of the
# repos they want to keep as standalone projects, then we break the loop 

echo "In this next portion, you will enter the indexes of the repos you want \
to keep as standalone projects, as they appear in the list above. When you \
are finished adding repos to this list, you may leave the field blank and \
then press Enter or Return."

# Blank line
echo


# Ergo, create a second py_repos list that will store the Python projects
# which should remain standalone repos
py_repos2=()

# Set the value of repo_num to a placeholder value just to initiate the while loop
index=0
# While loop will continue as long as repo_name isn't an empty string
while [ "$index" != "" ]; do
  # read -p allows for prompting and receiving user input in the same line
  # shellcheck disable=SC2162
  read -p "Enter an index, or leave the field blank to exit: " index
  # Blank line
  echo
  # DEBUG
  #echo -e "$index\n"
  # DEBUG
  #if [[ "$index" =~ ^-?[0-9]+$ ]]; then
  #  echo -e "$index is an integer.\n"
  #fi
  # If index isn't an empty string, i.e. no input
  if [[ "$index" != "" ]]; then
    repo="${py_num_repos[$index]}"
    # DEBUG
    #echo "$repo"
    py_repos2+=("$repo") 
  fi
  
  # Print py_repos2 so user doesn't mistakenly add the same project twice
  echo "Here is your list of projects you've added thus far:"
  # Echo contents of array user is creating for error prevention
  echo_array "${py_repos2[@]}"
  #for repo in "${py_repos2[@]}"; do
  #  echo "$repo"
  #done

#Blank line
echo

# End while loop
done

# Declare a new array that will contain the same repos as py_repos2, but will
# include the indexes
new_py_repos2=()

# In order to compare the repo names in the next step, we first have to edit
# out the indexes from the array we just created above
for repo in "${py_repos2[@]}"; do
  repo="${repo#* }"
  new_py_repos2+=("$repo")
done

# DEBUG
for repo in "${new_py_repos2[@]}"; do
  echo "Removed index: $repo"
done
echo

# Declare empty repo that will store the edited (remove numbers and space from 
# beginning of name) names of the projects in py_repos that AREN'T in
# py_repos2
py_repos3=()

# Define function that will remove the index numbers and space at the beginning
# of the repo names in py_repos IF it is not in the exclusion list (py_repos2), 
# then add the edited repo names to py_repos3
function edit_names () {
  # Set exit status to 1 by default to signal failure
  local found=1
  # This will iterate over all repos in py_repos one by one
  for repo1 in "${py_repos[@]}"; do
    # Needs to be reset after each iteration
    found=1
    # This nested for loop will iterate over py_repos2 looking for a match
    for repo2 in "${new_py_repos2[@]}"; do 
      # Parameter expansion cuts out everything up to, and including,
      # the first space, e.g. '0 py-small-projects'
      #cut_repo2="${repo2#* }"
      # Cut out everything in the repo name before the 'p'
      #cut_repo2="${repo2#*p}" 
      # DEBUG
      #echo "$cut_repo2"

      # If a repo from py_repos IS in py_repos2...
      if [[ "$repo1" != "$repo2" ]]; then
        # DEBUG
        echo "${repo1} is not a match for ${repo2}."
        # Pass, do nothing
        #:
      # If there's a match, found=0 to signal success, then break inner loop
      else 
        found=0 
        break
      fi
    # End INNER for loop
    done
    
    # If NO MATCH was found, then we add repo1 to py_repos3 so that it can be
    # lumped in with the other small projects
    if [[ "$found" -eq 1 ]]; then
      #cut_repo="${repo1#*p}" 
      #echo "$cut_repo"
      py_repos3+=("$repo1")
    fi
  # End OUTER for loop
  done
}


# Call function
edit_names

# Blank line
echo

echo -e "Please ensure that all of the repos in py_repos3 are projects you \
want to add to the py-small-projects repository:\n"

# Echo newly created array
echo_array "${py_repos3[@]}"

# Blank line
echo

# Create associate array as an object-like structure to store the various
# that will be presented to the user; this structure can be updated as needed
# to add new prompts for different actions
declare -A prompt
# This is the prompt that will be presented before running clone_repos
prompt[clone]="Do you want to move forward with cloning all of the projects \
in the above list into py-small-projects? [Y/n] "

function proceed() {
  local prompt="$1"
  read -p "$prompt" y_n
  # Use parameter expansion to ensure input is in lowercase (it will convert
  # if needed)
  local lower="${y_n,,}"
  echo
  # Process [Y/n] user input
  if [[ "$lower" == 'y' ]]; then
    # ':' means do nothing, and always returns a successful exit status (0)
    :
  elif [[ "$lower" == 'n' ]]; then
    echo -e "Exiting script now, please rerun and enter selections again.\n"
    exit 
  else
    echo -e "Invalid input, please try again.\n"
    # Call function recursively until valid input is entered
    proceed "$prompt"
  fi
}

# Function call
proceed "${prompt[clone]}"


# This function will be used in clone_repo() in the case that a repo does not
# get successfully cloned under py-small-projects/
function return_error() {
  local repo_name="$1"
  local error=$(echo -e "\nERROR: subdirectory ${repo_name} not found in \
py-small-projects. Please continue debugging the script.\n")
  echo "$error"
  # End script execution
  exit
}

# Define function that will clone repos to this repo
function clone_repo() {
  local main_gh_url="$1"
  local main_origin_url="$2"
  local repo_name="$3"
  # Concatenate above string variables
  local old_repo_url="$main_gh_url$repo_name"
  # DEBUG
  echo "old_repo_url: $old_repo_url"
  # Run the git command to clone the project as a subdirectory of this repo
  git clone "$old_repo_url"
  # Concatenate partial paths to create new URL to the repo under this parent
  #local new_repo_url="$2$3"
  # DEBUG
  #echo "$new_repo_url"
  # cd into the newly cloned repo; if the cloned repo is not found, the script
  # will return an error as defined in the function above this one
  #cd "$repo_name" || return_error "$repo_name"
  # Set the new remote origin for the cloned repo
  #git remote set-url origin "$new_remote_origin"
  # Change directories back into the py-small-projects parent
  #cd ..
}

# Define base URL
main_gh_url="https://github.com/blue-slushy9/"
this_repo="py-small-projects/"

# Define new remote origin URL (just needs repo name added at the end)
#main_origin_url=("$main_gh_url"+"py-small-projects/") # Incorrect syntax
main_origin_url="$main_gh_url$this_repo"
# DEBUG
echo "main_origin_url: $main_origin_url"

# Change directory into py-small-projects (we are currently in
# shell-scripts/)
cd ..

# Define counter that will keep track of how many repos get cloned
n=0
# Iterate over py_repos3 array, run 'git clone' on each repo therein
for repo in "${py_repos3[@]}"; do
  clone_repo "$main_gh_url" "$main_origin_url" "$repo"
  ((n++))
done

# Iterate over py-small-projects and verify all of the projects in 
# py_repos3 have been cloned
function verify_clones() {
# JUNK CODE  
  # Declare counter to keep track of how many repos from py_repos3 are found
  # in py-small-projects
  local n=0
  # Set exit status to 1 by default to signal failure
  local found=1
  for repo1 in "${py_repos3[@]}"; do
    # Needs to be reset after each iteration
    found=1
    # './' means working directory, which is 'py-small-projects/'
    for repo2 in ./; do
      if [[ "$repo1" != "$repo2" ]]; then
        # Pass, do nothing
        :  
      # If there's a match, found=0 to signal success, then break inner loop
      else
        found=0
        break
      fi
    done

    # If the exit status was successful
    if [[ "$found" -eq 0 ]]; then
      # Raise counter by 1
      ((n++))
    fi
  done
# /JUNK CODE
  
  # Calculate the number of array elements in py_repos3 and assign to variable
  local x=${#py_repos3[@]}
  
  # Compare our counter n with the number of repos in py_repos3
  if [[ "$n" -eq  "$x" ]]; then
    echo -e "All repos in py_repos3 have been cloned to py-small-projects.\n"
  else
    echo -e "ERROR: Not all repos in py_repos3 have been cloned to \
py-small-projects. Please rerun script or finish process manually.\n"
    exit
  fi
}

# Function call
verify_clones

# Move back to our working directory for this script
cd shell-scripts/

# Add a prompt to the associate array asking whether user wants to move
# move forward with deleting the repos that were just cloned
prompt[delete_repos]="Do you want to move forward with deleting all of the \
repos that were just cloned into py-small-projects? [Y/n] "

# Call proceed function to ensure user wants to move forward with final steps
proceed "${prompt[delete_repos]}"

# You may need to run this command to be able to delete repos, depending on
# whether the token has expired
#gh auth refresh -h github.com -s delete_repo
# View status of your tokens, including permissions scopes
#gh auth status
# Refresh all existing tokens and permission scopes
#gh auth refresh

# Define function that will be used to delete old GitHub repos once they have
# cloned to py-small-projects
function delete_repos() {
  for repo in "${py_repos3[@]}"; do
    # The --yes switch bypasses the confirmation prompt
    gh repo delete --yes "$repo"
  done
}

# Function call
delete_repos

COMMENT

# Add prompt to associative array that will ask user whether they want to move
# forward with mergeing the testing branch into the main branch
prompt[merge]="Do you want to move forward with merging the testing branch \
of py-small-projects into the main branch? [Y/n] "

# Function call
proceed "${prompt[merge]}"

# Define function that will merge the current branch of py-small-projects,
# test, into the main branch
function merge_to_main() {
  # Switch over into main branch, which is our target branch
  git checkout main
  # Merge the test branch into main
  git merge testing 
}

# Function call
merge_to_main

# Add prompt to the associative array that asks user whether they want to
# delete the testing branch that they just merged above
prompt[delete_branch]="Do you want to move forward with deleting the testing \
branch of py-small-projects? [Y/n] "

# Function call
proceed "${prompt[delete_branch]}"

# Define function that will delete our testing branch after the merge to main
function delete_branch() {
  # Delete local branch (this command verifies if it's already merged)
  git branch -d testing 
  # Delete the remote branch
  git push origin --delete testing
}

# Function call
delete_branch

# Blank line
echo

# Success message
echo -e "Congratulations, the script has finished running! You have now \
finished moving your repos into py-small-projects and the clean-up process.\n"
