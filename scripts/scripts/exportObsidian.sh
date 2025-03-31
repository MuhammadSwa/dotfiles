#!/bin/bash
#TODO: detect regressive [[]] 

# list of files
withBrackets=$(grep '\[\[' /home/alien/MyVault/Areas/Dentistry/HOME\!\ ergonomics.md  | grep -v '\.png]]')

# s - tells sed to substitute
# / - start of regex string to search for
# [^"]* - any character that is not ", any number of times. (matching parameter name=)
# \[\[ - just a [[
# ([^"]*) - anything inside () will be saved for reference to use later. The \ are there so the brackets are not considered as characters to search for. [^"]* means the same as above. (matching RemoteHost for example)
# .* - any character, any number of times. (matching " access="readWrite"> /parameter)
# \]\] - just a ]]
# / - end of the search regex, and start of the substitute string.
# \1 - reference to that string we found in the brackets above.
# / end of the substitute string.
files=$(echo "$withBrackets" | sed 's/[^"]*\[\([^"]*\).*\]\]/\1/')

paths=()

## Reach each file name and search for it's path in the vault
# while IFS= read -r line
# do
#   path=$(find "$HOME/MyVault/" -name "$line.md")
#   paths+=("$path")
# done < <(printf '%s\n' "$files")

while IFS= read -r line
do
  # Check if line has [[]]
  doesExist=$(echo "$line" | grep '\[\[[^"]*\]\]' | grep -v '\.png' | wc -l)
  if [ "$doesExist" -ne 0 ]
  then
  withoutBracket=$(echo $line | sed 's/[^"]*\[\([^"]*\).*\]\]/\1/')
  path=$(find "$HOME/MyVault/" -name "$withoutBracket.md")
  cat "$path" >> "$HOME/MyVault/mainfile.md"
  # printf "\n---\n" >> "$HOME/MyVault/mainfile.md"
else
  echo "$line" >> "$HOME/MyVault/mainfile.md" 
  fi
  # echo $line >> "$HOME/MyVault/mainfile.md" 
done < /home/alien/MyVault/Areas/Dentistry/HOME\!\ ergonomics.md 


## loop over paths by order and combine all in one file
# for i in "${!paths[@]}"; do
#   cat "${paths[$i]}" >> "$HOME/MyVault/mainfile.md"
#   printf "\n---\n" >> "$HOME/MyVault/mainfile.md"
# done


### WE want to loop over ergonomics and when we find a double bracket we find and then add it to this line

# input="$HOME/MyVault/Areas/Dentistry/HOME! ergonomics.md"
## Read the list | 

# while IFS= read -r line
# do
#   echo "$line"
# done < "$files"
