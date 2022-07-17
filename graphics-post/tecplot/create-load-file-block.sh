#!/bin/bash

# Header block layout for Tecplot layout files.
#   #!MC 1410
#   $!VarSet |LFDSFN1| = '<file_list>'
#   $!VarSet |LFDSVL1| = '<variable_list>'
#   ...

layout_file="<layout_file>"
parent_dir="<parent_dir>"
fname=("<name_pattern_1>" "<...>")

# Construct header block.
header_block=$( printf "#!MC 1410\n"
for i in "${!fname[@]}"; do
    file_list=$(find "$parent_dir" -path "**/${fname[i]}" -printf "\"%p\" " | sed -e 's/[[:space:]]*$//')
    line_num="$(((i+1)*2+1))"
    var_list=$(sed "${line_num}q;d" $layout_file)
    printf "\$!VarSet |LFDSFN%s| = '$file_list'\n%s\n" "$((i+1))" "$var_list"
done )

# Count the number of lines.
num_lines=$(echo "$header_block" | wc -l)
# Delete the existing header block.
sed -i -e 1,${num_lines}d $layout_file
# Prepend the new header block to the file.
echo -e "$header_block\n$(cat $layout_file)" > $layout_file