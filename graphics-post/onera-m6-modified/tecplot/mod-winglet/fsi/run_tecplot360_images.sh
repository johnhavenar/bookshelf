#!/bin/bash

# This script uses the executes the shell script 'create-fluid-tiled-contour-layout.sh'to modify
# the Tecplot layout file 'fluid-tiled-contour-layout.lay' and 'create-frame-export-fluid-macro.sh'
# to create the Tecplot animation macro 'frame-export-fluid.mcr' from the template text
# 'frame-export-fluid-template.txt' for the flow parameters of angle of attack and Mach number,
# and then run them to export each frame as an image and renumber them by timestep.

# Depends on: create-fluid-tiled-contour-layout.sh, fluid-tiled-contour-layout.lay, create-frame-export-fluid-macro.sh, frame-export-fluid-template.txt

LAYOUT_FILE="fluid-tiled-contour-layout.lay"
MACRO_TEMPLATE_FILE="frame-export-fluid-template.txt"
MACRO_FILE="frame-export-fluid.mcr"

LAYOUT_MOD_SCRIPT="create-fluid-tiled-contour-layout.sh"
MACRO_CREATE_SCRIPT="create-frame-export-fluid-macro.sh"

FRAME_SKIP=1

declare -a AnglesOfAttack=(6)
declare -a MachNumbers=(0.90)
declare -a SpanSections=(0.20 0.40 0.60 0.70 0.80 0.85 0.90 0.95 1.00)


# Iterate through angles of attack.
for AoA in ${AnglesOfAttack[@]}; do

	# Iterate through Mach numbers.
	for M in ${MachNumbers[@]}; do

        # Make temporary case-specific directory.
        TEMP_DIR=../_temp/active-scripts/$AoA-$M
        # Assign shorthand for temporary directory.
        mkdir -p $TEMP_DIR

        # Run shell scripts to modify the Tecplot macro and layout.
        bash $LAYOUT_MOD_SCRIPT $AoA $M
        bash $MACRO_CREATE_SCRIPT $AoA $M $FRAME_SKIP

        # Copy modified script files to the temporary directory.
        cp $LAYOUT_FILE $MACRO_FILE $TEMP_DIR

        (# LAUCH SUBSHELL
        # Directory of Mach number image files.
        MACH_NUMBER_IMAGE_DIR=/mnt/d/Aeroelasticity/onera-m6-modified/mod-winglet/results/fsi/images/fluid/contour-frames/mach-number/$AoA-$M
        mkdir -p $MACH_NUMBER_IMAGE_DIR
        # Directory of pressure image files.
        PRESSURE_IMAGE_DIR=/mnt/d/Aeroelasticity/onera-m6-modified/mod-winglet/results/fsi/images/fluid/contour-frames/pressure/$AoA-$M
        mkdir -p $PRESSURE_IMAGE_DIR
        # Directory of velocity image files.
        VELOCITY_IMAGE_DIR=/mnt/d/Aeroelasticity/onera-m6-modified/mod-winglet/results/fsi/images/fluid/contour-frames/velocity/$AoA-$M
        mkdir -p $VELOCITY_IMAGE_DIR
        
        # Run Tecplot, remove temporary files upon exit.
        tec360.exe -b -p ./$TEMP_DIR/$MACRO_FILE ./$TEMP_DIR/$LAYOUT_FILE; tail --pid=$! -f /dev/null; rm -r $TEMP_DIR

        # Rename Mach number image files to change timestamps from the "_000001" format to the "0.001" format
        # while preserving the span section location of the contour in the file name.
        for eta in ${SpanSections[@]}; do
            a=0
            for i in $MACH_NUMBER_IMAGE_DIR/mach-number-$eta-*_000*.png; do
            new=$(printf "$MACH_NUMBER_IMAGE_DIR/mach-number-$eta-$AoA-$M-0.%03d.png" "$a")
            mv "$i" "$new"; let "a=a+$FRAME_SKIP"; done
        done
        
        # Rename pressure image files to change timestamps from the "_000001" format to the "0.001" format
        # while preserving the span section location of the contour in the file name.
        for eta in ${SpanSections[@]}; do
            a=0
            for i in $PRESSURE_IMAGE_DIR/pressure-$eta-*_000*.png; do
            new=$(printf "$PRESSURE_IMAGE_DIR/pressure-$eta-$AoA-$M-0.%03d.png" "$a")
            mv "$i" "$new"; let "a=a+$FRAME_SKIP"; done
        done
        
        # Rename velocity image files to change timestamps from the "_000001" format to the "0.001" format
        # while preserving the span section location of the contour in the file name.
        for eta in ${SpanSections[@]}; do
            a=0
            for i in $VELOCITY_IMAGE_DIR/velocity-$eta-*_000*.png; do
            new=$(printf "$VELOCITY_IMAGE_DIR/velocity-$eta-$AoA-$M-0.%03d.png" "$a")
            mv "$i" "$new"; let "a=a+$FRAME_SKIP"; done
        done
        ) &
        
        # Print to console.
        echo "[  AoA=$AoA°, M=$M  ]"

    done

done