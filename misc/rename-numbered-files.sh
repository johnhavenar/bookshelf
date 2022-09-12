#!/bin/bash

file_dir="<directory-of-files>"
file_name="<file-name>"
file_type="png"
num_field_char="_"
num_field_width=6

a=1
for i in $file_dir/*.${file_type}; do
  new=$(printf "$file_dir/${file_name}${num_field_char}%0${num_field_width}d.${file_type}" "$a")
  mv -i -- "$i" "$new"
  let a=a+1
done