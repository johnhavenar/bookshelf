#!/bin/bash

# This script modifies the Tecplot layout file 'fluid-tiled-contour-layout.lay' for the given flow parameters
# by replacing the list of files to be read and the text annotation on the plots.

# Layout file to be modified.
FILE=fluid-tiled-contour-layout.lay

# Flow parameters for data file input.
ANGLE=$(printf "%1.0f" $1)
MACH=$(printf "%1.2f" $2)
DURATION=200 # Duration in milliseconds.

# Iteratively create a variable containing a list of files.
i=0
while [ $i -le $DURATION ]
do
    LIST=${LIST}$(printf "\\\"E:\/Aeroelasticity Research\/onera-m6-modified\/mod-winglet\/data\/rigid\/$ANGLE-$MACH\/continuum-data\/continuum-data-$ANGLE-$MACH-0.%03d.dat.plt\" " "$i")
    let i=i+1
done
LIST="\$!VarSet \|LFDSFN1\| = '"${LIST}"'"

# Replace existing file input line with new file list stored in the newly created variable.
sed -i "s|.*VarSet \|LFDSFN1\|.*|$LIST|g" $FILE
