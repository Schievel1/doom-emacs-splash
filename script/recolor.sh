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
if [[ $# -ne 1 ]]; then
  # Print error to stderr
  echo -e "${RED}[!] $# arguments passed, 1 required${RESET}" >&2
  # Print usage
  echo -e "${CYAN}[?] usage: ./recolor.sh [output filename]${RESET}"
  echo -e "${CYAN}[?] Colors must be in HEX format: 434C5E, f13${RESET}"
  exit 2
fi

# Recolor
# get the colors from the user
read -p "input the top gradient color of the text. Hex format, e.g. 434c5e: " topgradient
read -p "input the bottom gradient color of the text: " bottomgradient
read -p "input the upper outlines color of the doom text: " doomoutlines
read -p "input the color of the shadows: " shadow
read -p "input the background color: " background
read -p "input the color of the dot in the middle that the background gradients to: " middledot

cp "template.svg" "${1}.svg" # Copy output file
outputfile=${1}".svg"

sed -i "s/fffff9/${topgradient}/g" $outputfile # Top gradient color of the text
sed -i "s/fffffa/${bottomgradient}/g" $outputfile # Bottom gradient color of the text
sed -i "s/fffffb/${doomoutlines}/g" $outputfile # The upper outlines of the 'DOOM' text
sed -i "s/fffffc/${shadow}/g" $outputfile # The shadow
sed -i "s/fffffd/${background}/g" $outputfile # The background
sed -i "s/fffffe/${middledot}/g" $outputfile # Dot in the middle that the background gradients to

echo -e "${GREEN}[+] Success!${RESET}"

# If feh command exists, show image
if [[ $(command -v feh) ]]; then
  echo -e "${CYAN}[?] feh is installed on the system, opening image...${RESET}"
  feh "$1"
fi
