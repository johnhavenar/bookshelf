#!/bin/bash

# This script finds all '.mp4' files in the directory structure
# and converts them to a 1080p resolution and 16:9 aspect ratio.

file_list=( $(find . -name "*.mp4") )

for FILE in ${file_list[@]}; do

    mv $FILE temp.mp4
    ffmpeg -y -i temp.mp4 -vf "scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:-1:-1:color=white" $FILE
    rm temp.mp4

done
