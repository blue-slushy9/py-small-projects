#!/bin/fish

# NOTE: not sure if I will continue with this script, fish may be too obscure
# to work with and perhaps not very reliable; I am making a bash version of
# this script for the time being.

# Retrieve all of my Python GitHub repos and save the output to an object/variable ?
# NOTE: unfortunately the feature that is supposed to filter the output by
# language doesn't seem to work very well
#gh repo list -l 'Python' -L 120

# Define function that will split our <user-name/repo-name> strings in the 
# next step
function splitter input_string
  # Use 'string split' method in fish to excise everything up to and including
  # the '/'
  set split_string (string split --at=/ input_string)
  # First element is empty, second is everything after the delimiter ('/');
  # i.e. the repo name only
  return split_string[1]
# End of function definition
end

# Retrieve all of my GitHub repos and create an array to store the output; 
# had to use the '-L 120' switch because 'gh repo list' only outputs 30 repo
# names by default;
# the 'awk' portion extracts column 1 only, which is in the format
# <user name/repo name>; then we pipe that output to the 'string split' method
# in fish to delete everything up to and including the '/'
all_repos = (gh repo list -L 120 | awk '{print $1}' | splitter)

# Define function for extracting the first three characters of the repo name,
# which we will use in the next step
function get_first_three input_string
  # Use the 'string sub' method in fish to extract the first three characters
  # in the string (will be used for repo names to check if it is 'py-')
  set first_three (string sub --from=1 --length=3 input_string)
  return $first_three
end

# Declare empty array for storing Python repos, to be populated in next step
py_repos = ""

# It seems like removing array elements might be onerous in fish, probably
# better to simply find matches for 'py-' and add them to a separate array;
# Now iterate over the array and append all of the Python repos to the array;
for repo in $all_repos; do

  # Call first_three function to extract first three characters of repo name
  first_three = get_first_three $repo
  # If repo name begins with 'py-'...
  if $first_three == "py-"
    # Create a new array that will store the Python repo names only, then append 
    # the Python repo name to it 
    set py_repos = (string append py_repos $repo)
  
  end
end

# End for loop
#done

# DEBUG
echo "all_repos:" 
echo $all_repos
echo "py_repos:"
echo $py_repos

# Out of those py_repos, a handful of them will remain their own standalone
# projects; the script will have to prompt to see which should NOT be added
# to our consolidated repo

# Ergo, create a second py_repos list that will NOT include the Python projects
# which should remain standalone projects
py_repos2 = ""

# Set the value of current_repo to a placeholder string just to initiate the while loop
current_repo = "foo"
# Create a while loop that will continue for as long as user enters any input,
# because no input is interpreted as an empty string
while $current_repo != ""
  echo "Please enter the name of the Python repo you wish to exclude from the \
       consolidation process. If you are finished adding repos to the exclude \
       list, please just press Enter: "
  # read will receive the user input and assign it to the variable
  read current_repo
  # Use the 'set -p' method in fish to prepend a value to an array
  set -p py_repos2 $current_repo  
  # Show current exclusion list
  echo "This is the current repo exclusion list: "
  echo $py_repos2
  # Append the repo name to our list of repos to be left as standalones
  #set py_repos2 (string append py_repos2 current_repo)

 
end

# Retrieve all of my GitHub repos and save the output to a text file ?

# Declare list of repos that will NOT be moved over to the new target repo

# Iterate over the list of all repos, if it is a Python repo that is NOT in
# the exclude list, then we use git to link it to our target repo

# 
