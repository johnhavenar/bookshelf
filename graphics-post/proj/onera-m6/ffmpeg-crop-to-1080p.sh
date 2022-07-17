#!/bin/bash

# The purpose of this script is to crop existing MP4 files into
# a 16:9 aspect ratio video at 1080p.

# The inputs were copied from the ONERA M6 study working directory: '/mnt/d/Aeroelasticity/onera-m6/onera-m6-wing-basic/data'.


ffmpeg -i "structural-transient-3.mp4" -filter:v "crop=1920:1080:0:0" -vcodec libx265 -crf 24 "ONERA M6 Wing, AoA=2°, M=0.95 - Flutter - Structural Response.mp4"

ffmpeg -i "contour-lines-transient-2.mp4" -filter:v "crop=1920:1080:0:100" -vcodec libx265 -crf 24 "ONERA M6 Wing, AoA=2°, M=0.95 - Flutter - Velocity Contour Lines.mp4"

ffmpeg -i "vectors-transient-1.mp4" -filter:v "crop=1920:1080:0:100" -vcodec libx265 -crf 28 "ONERA M6 Wing, AoA=2°, M=0.95 - Flutter - Trailing Edge Velocity Vectors.mp4"