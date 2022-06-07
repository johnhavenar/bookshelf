#!/bin/bash


# This script works by replacing the strings "FLOW_ANGLE" and "FLOW_MACH" in the template text file
# "frame-export-fluid-template.txt" to create a Tecplot macro file to export images of Mach number,
# pressure, and velocity at 1 ms intervals at locations along the span. These images have not legend
# or annotation.

MACRO_TEMPLATE_FILE="frame-export-fluid-template.txt"
MACRO_FILE="frame-export-fluid.mcr"
ANGLE=$1
MACH=$2

# Format numerical inputs as strings for naming files.
ANGLE_STRING=$(printf "%1.0f" $ANGLE)
MACH_STRING=$(printf "%1.2f" $MACH)

# Set graphics export parameters.
FRAME_SKIP=$3
IMAGE_WIDTH=1920

# Modify flow parameters and image export settings.
sed -e "s|FLOW_ANGLE|$ANGLE_STRING|g" -e "s|FLOW_MACH|$MACH_STRING|g" -e "s|GRAPHICS_FRAME_SKIP|$FRAME_SKIP|g" -e "s|GRAPHICS_IMAGE_WIDTH|$IMAGE_WIDTH|g" $MACRO_TEMPLATE_FILE > $MACRO_FILE