#!/bin/bash

# Get source directory of this script file.
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";
echo $SCRIPT_DIR

# Script to be run in subdirectories.
SCRIPT="<script_name>"

# Get list of directories.
IFS=$'\n'
file_list="$(find . -type f -name '<pattern>' -exec dirname "{}" \; |sort -u)"

# Go to directory and run script.
for directory in ${file_list[@]}; do
    cd $directory
    pwd
    cp "$SCRIPT_DIR/$SCRIPT" .
    bash "$SCRIPT"
    rm "$SCRIPT"
    cd $SCRIPT_DIR
done
