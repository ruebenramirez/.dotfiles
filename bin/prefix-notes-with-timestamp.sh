#!/bin/bash


DEBUG=false

dbg() {
    local message="$1"
    if $DEBUG; then
        echo ">>>: $message"
    fi
}


# Specify the directory path
directory="/mnt/c/Users/ruebe/Documents/notes"

# Check if the directory exists
if [ ! -d "$directory" ]; then
    dbg "Directory $directory not found."
    exit 1
fi

# Move to the directory
cd "$directory" || exit

# Loop through each markdown file in the directory
for file in *; do
    dbg "evaluating file: $file"
    # Check if the item is a file and if its name is not already prefixed with a timestamp
    if [ ! -f "$file" ]; then
        dbg "skipping because this $file is not a file"
        continue
    fi

    if [[ ! "$file" =~ \.md$ ]]; then
        dbg "$file is not markdown"
        continue
    fi

    if [[ "$file" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2} ]]; then
        dbg "skipped $file since it's already prefixed with a datestamp"
        continue
    fi

    if [[ "$file" =~ ^[0-9]{12} ]]; then
        dbg "skipped $file since it's already prefixed with a timestamp"
        continue
    fi


    # Get the last modified time of the file
    timestamp=$(stat -c "%Y" "$file")

    # Format the timestamp as a readable date
    datetime=$(date -d @"$timestamp" "+%Y%m%d%H%M%S")

    # Rename the file with prefix as the timestamp
    # TODO: remove the echo from the following line to enable the mv
    echo mv "$file" "${datetime} ${file}"

    dbg "Renamed $file to ${datetime} ${file}"

done

