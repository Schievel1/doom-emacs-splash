#! /usr/bin/env bash
#
# ████████╗ |                 GRAPHICS
# ╚══██╔══╝ |         tachanka61 and Schievel1
#    ██║    |
#    ██║    | https://github.com/tachanka61/graphics
#    ██║    | Dependencies: sed, doomEmacs.svg
#    ╚═╝    |

# This makes program more secure
# Also you can enable 'x' flag to enable debug
set -euo pipefail

# File that will be recolored
file="doomEmacs.svg"
recolored_file="CUSTOMdoomEmacs.svg"

# You should insert HEX color code without '#': text_shadow="eceff4"
text_gradient_top=""  # Top gradient color of the text
text_gradient_bottom=""  # Bottom gradient color of the text
text_shadow=""  # The upper outlines of the 'DOOM' text
sphere_shadow=""  # The shadow
sphere_background=""  # The background
sphere_light=""  # Dot in the middle that the background gradients to

# Recolor
cp "$file" "$recolored_file"

sed -i "s/5e81ac/$text_gradient_top/g" "$recolored_file"
sed -i "s/b48ead/$text_gradient_bottom/g" "$recolored_file"
sed -i "s/4c566a/$text_shadow/g" "$recolored_file"
sed -i "s/3b4252/$sphere_shadow/g" "$recolored_file"
sed -i "s/2e3440/$sphere_background/g" "$recolored_file"
sed -i "s/434c5e/$sphere_light/g" "$recolored_file"
