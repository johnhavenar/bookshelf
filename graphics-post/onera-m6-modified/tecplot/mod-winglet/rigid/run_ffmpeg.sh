#!/bin/bash

# Run ffmpeg to create animations of field scalar contours at multiple span section
# locations for multiple angles of attack and freestream Mach numbers.

# Parent directories.
INPUT_PARENT_DIR="/mnt/d/Aeroelasticity/onera-m6-modified/mod-winglet/results/rigid/images/fluid/contour-frames"
OUTPUT_PARENT_DIR="/mnt/d/Aeroelasticity/onera-m6-modified/mod-winglet/results/rigid/animations/fluid/contours"


declare -a ContourFields=("mach-number" "pressure" "velocity")
declare -a AnglesOfAttack=(2 4)
declare -a MachNumbers=(0.80 0.90 1.00 1.10 1.20 1.40)
declare -a SpanSections=(0.20 0.40 0.60 0.70 0.80 0.85 0.90 0.95)

# Loop over each scalar field.
for field in ${ContourFields[@]}; do

    # Iterate through angles of attack.
    for AoA in ${AnglesOfAttack[@]}; do

        # Iterate through Mach numbers.
        for M in ${MachNumbers[@]}; do

            # Iterate through span section locations.
            for eta in ${SpanSections[@]}; do

            # Create input and output directories and assign shorthand.
            INPUT_DIR=$INPUT_PARENT_DIR/$field/$AoA-$M; mkdir -p $INPUT_DIR
            OUTPUT_DIR=$OUTPUT_PARENT_DIR/$field; mkdir -p $OUTPUT_DIR

            # Run ffmpeg.
            ffmpeg -framerate 30 -pattern_type glob -i "$INPUT_DIR/$field-$eta-$AoA-$M-*.png" -vcodec libx264 -crf 15 "$OUTPUT_DIR/$field-$eta-$AoA-$M.mp4"

            done

        done

    done

done
