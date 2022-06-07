#!/bin/bash

# Run ffmpeg to create animations of dynamic pressure and pressure coefficient.

# Directories.
INPUT_PARENT_DIR="/mnt/d/Aeroelasticity/onera-m6-modified/mod-extension/results/rigid/images/fluid/contour-frames"
OUTPUT_PARENT_DIR="/mnt/d/Aeroelasticity/onera-m6-modified/mod-extension/results/rigid/animations/fluid/contours"


declare -a Variables=("dynamic-pressure" "pressure-coefficient")
declare -a AnglesOfAttack=(2 4 6)
declare -a MachNumbers=(0.80 0.90 1.00 1.20 1.40)
declare -a Modification=("winglet" "extension")
declare -a AnalysisType=("fsi" "rigid")

# Loop over wing modifications.
for mod in ${Modification[@]}; do
    # Loop over analysis type.
    for analysis in ${AnalysisType[@]}; do
        # Loop over each scalar variable.
        for variable in ${Variables[@]}; do
            # Iterate through angles of attack.
            for AoA in ${AnglesOfAttack[@]}; do
                # Iterate through Mach numbers.
                for M in ${MachNumbers[@]}; do

                    # Specify input and output directories and assign shorthand.
                    INPUT_DIR="/mnt/d/Aeroelasticity/onera-m6-modified/mod-$mod/results/$analysis/images/fluid/$variable/$AoA-$M/"
                    OUTPUT_DIR="/mnt/d/Aeroelasticity/onera-m6-modified/mod-$mod/results/$analysis/animations/fluid/$variable/"
                    # Run ffmpeg.
                    ffmpeg -y -threads 0 -framerate 30 -pattern_type glob -i "$INPUT_DIR/$variable-$AoA-$M-*.png" -vcodec libx264 -crf 10 "$OUTPUT_DIR/$variable-$AoA-$M.mp4"

                done
            done
        done
    done
done