#!/bin/bash

# Get source directory of this script file.
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";
echo $SCRIPT_DIR

# Get list of directories.
IFS=$'\n'
file_list="$(find . -type f -name '*0.???.png' -exec dirname "{}" \; |sort -u)"

# Go to directory and run script.
for directory in ${file_list[@]}; do
    cd $directory
    pwd
    cp "$SCRIPT_DIR/convert-aspect-ratio.sh" .
    bash "convert-aspect-ratio.sh"
    rm "convert-aspect-ratio.sh"
    cd $SCRIPT_DIR
done
