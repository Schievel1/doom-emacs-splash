#! /usr/bin/env bash
#
# ████████╗ |                 GRAPHICS
# ╚══██╔══╝ |         tachanka61 and Schievel1
#    ██║    |
#    ██║    | https://github.com/tachanka61/graphics
#    ██║    | Dependencies: sed, doomEmacs.svg
#    ╚═╝    | Optional: feh

# This makes program more secure
# Also you can enable 'x' flag to enable debug
set -euo pipefail

GREEN='\033[0;32m'
RED='\033[0;31m'
CYAN='\033[;36m'
RESET='\033[0m'

# Check for arguments
if [[ $# -ne 8 ]]; then
  # Print error to stderr
  echo -e "${RED}[!] $# arguments passed, 8 required${RESET}" >&2
  # Print usage
  echo -e "${CYAN}[?] usage: ./recolor.sh [file] [output] [gradient_color_top] [gradient_color_bottom] [letter_shadow] [sphere_shadow] [background] [light_background]${RESET}"
  echo -e "${CYAN}[?] Colors should be in HEX format: 434C5E, f13${RESET}"
  exit 2
fi

# Recolor
cp "$1" "$2" # Copy output file

sed -i "s/5e81ac/$3/g" "$2" # Top gradient color of the text
sed -i "s/b48ead/$4/g" "$2" # Bottom gradient color of the text
sed -i "s/4c566a/$5/g" "$2" # The upper outlines of the 'DOOM' text
sed -i "s/3b4252/$6/g" "$2" # The shadow
sed -i "s/2e3440/$7/g" "$2" # The background
sed -i "s/434c5e/$8/g" "$2" # Dot in the middle that the background gradients to

echo -e "${GREEN}[+] Success!${RESET}"

# If feh command exists, show image
if [[ $(command -v feh) ]]; then
  echo -e "${CYAN}[?] feh is installed on the system, opening image...${RESET}"
  feh "$2"
fi
