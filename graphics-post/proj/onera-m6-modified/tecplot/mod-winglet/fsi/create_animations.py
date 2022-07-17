from pathlib import Path
from PIL import Image
import os
import ffmpeg


def detect_color(rgb, filename):
    img = Image.open(filename)
    img = img.convert('RGBA')
    data = img.getdata()

    for item in data:
        if item[0] == rgb[0] and item[1] == rgb[1] and item[2] == rgb[2]:
            return str(filename)

# Contour field scalars.
contour_list = ["mach-number", "pressure", "velocity"]
# Angles of attack.
angle_list = [6]
# Freestream Mach numbers.
mach_list = [0.90]
# Span section locations.
section_list = [0.20, 0.40, 0.60, 0.70, 0.80, 0.85, 0.90, 0.95]

# Parent directory.
parent_dir = "/mnt/d/Aeroelasticity/onera-m6-modified/mod-winglet/results/fsi/images/fluid/contour-frames"
# Animation parent directory.
anim_parent_dir = "/mnt/d/Aeroelasticity/onera-m6-modified/mod-winglet/results/fsi/animations/fluid/contours"

# Iteratively find and delete corrupted images and interpolate replacement frames.
for contour in contour_list:
    for angle in angle_list:
        for mach in mach_list:
            for section in section_list:

                # Construct directory paths.
                case_dir = '%.0f-%.2f' % (angle, mach)  # Case directory for flow parameters.
                image_dir = Path(parent_dir) / contour / case_dir  # Path of image directory.

                file_list = Path(image_dir).glob('%s-%.2f-%.0f-%.2f-*.png' % (contour, section, angle, mach))
                all_file_list = []
                keep_file_list = []

                for image_file in file_list:
                    all_file_list.append(str(image_file))
                    image_path = detect_color((255, 255, 255), image_file)
                    if image_path != None:
                        keep_file_list.append(image_path)

                print('[  AoA=%.0f, M=%.2f  ]' % (angle, mach))
                print("Total number of files: ",len(all_file_list))
                print("Number of healthy files:", len(keep_file_list))

                remove_file_list = list(set(all_file_list) - set(keep_file_list))
                for delete_file in remove_file_list:
                    print("Deleting: ",delete_file)
                    os.remove(delete_file)

                # Strings to be used in the ffmpeg command.
                input_frame_files = str(image_dir)+'/%s-%.2f-%.0f-%.2f-*.png' % (contour, section, angle, mach)
                output_animation = str(anim_parent_dir)+'/%s/%s-%.2f-%.0f-%.2f.mp4' % (contour, contour, section, angle, mach)
                print(input_frame_files)
                print(output_animation)

                # Make animation directory if it does not exist.
                output_dir_path = str(anim_parent_dir)+'/%s' % contour
                if not os.path.exists(output_dir_path):
                    os.makedirs(output_dir_path)

                # Run ffmpeg.
                (
                ffmpeg
                .input(input_frame_files, pattern_type='glob', framerate=30)
                .output(output_animation, crf=15, vcodec='libx264')
                .run(overwrite_output=True, quiet=True)
                )