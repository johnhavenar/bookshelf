#!/bin/bash

# Renames files in a directory.

# Directory of files.
file_dir="<directory-of-files>"
# Name of files in series.
file_name="<file-name>"
file_type="png"
# Phrase which separates the file and the numbering.
num_field_char="_"
# Field width of numbering.
num_field_width=6
# First number in series.
num_first=1
# Shift the numbering by this amount to renumber items.
num_shift=0

a=$(($num_first+$num_shift))
for i in $file_dir/*.${file_type}; do
  new=$(printf "$file_dir/${file_name}${num_field_char}%0${num_field_width}d.${file_type}" "$a")
  mv -i -- "$i" "$new"
  let a=a+1
done
