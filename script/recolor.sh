#! /usr/bin/env bash
#
# ████████╗ |                 GRAPHICS               |  ______     _____
# ╚══██╔══╝ |         tachanka61 and Schievel1       | |_   __ \  |_   _|
#    ██║    |                                        |   | |__) |   | |
#    ██║    | https://github.com/tachanka61/graphics |   |  ___/ _  | |
#    ██║    | Dependencies: sed, doomEmacs.svg       |  _| |_   | |_| |
#    ╚═╝    | Optional: feh                          | |_____|  \.___.'
#           |                                        |

# Shellcheck stuff:
# shellcheck disable=SC2162

# This makes program more secure
# Also you can enable 'x' flag to enable debug
set -euo pipefail

GREEN=$'\033[0;32m'
RED=$'\033[0;31m'
CYAN=$'\033[;36m'
RESET=$'\033[0m'

# Check for arguments
if [[ $# -ne 1 ]]; then
  # Print error to stderr
  echo -e "${RED}[!] $# arguments passed, 1 required${RESET}" >&2
  # Print usage
  echo -e "${CYAN}[?] usage: ./recolor.sh [output filename]${RESET}"
  exit 2
fi

# Recolor
# get the colors from the user
colors=(topgradient bottomgradient doomoutlines shadow background middledot)
color_msg=("Input the top gradient color of the text. It should be in HEX format, e.g. 434C5E or f13: " \
  "Input the bottom gradient color of the text: " \
  "Input the upper outlines color of the Doom text: " \
  "Input the color of the shadows: " \
  "Input the background color: " \
  "Input the color of the dot in the middle that the background gradients to: ")
for i in {0..5}
do
  while ! [[ ${colors[i]} =~ ^([[:xdigit:]]{3}){1,2}$ ]]
  do read -p "${CYAN}[>] ${color_msg[i]}${RESET}" color
     colors[i]=$color
     if ! [[ ${colors[i]} =~ ^([[:xdigit:]]{3}){1,2}$ ]]; then
      echo -e "${RED}[!] Invalid color!${RESET}"
      echo -e "${CYAN}[?] Colors must be in HEX format: 434C5E, f13${RESET}"
      echo -e "${CYAN}[-] Try again. Abort with CTRL+C.${RESET}"
     fi
  done
done

cp "template.svg" "${1}.svg" # Copy output file
output_file=${1}".svg"

sed -i "s/fffff9/${colors[0]}/g" "$output_file" # Top gradient color of the text
sed -i "s/fffffa/${colors[1]}/g" "$output_file" # Bottom gradient color of the text
sed -i "s/fffffb/${colors[2]}/g" "$output_file" # The upper outlines of the 'DOOM' text
sed -i "s/fffffc/${colors[3]}/g" "$output_file" # The shadow
sed -i "s/fffffd/${colors[4]}/g" "$output_file" # The background
sed -i "s/fffffe/${colors[5]}/g" "$output_file" # Dot in the middle that the background gradients to

echo -e "${GREEN}[+] Success!${RESET}"

# Ask user for image preview
if [[ $(command -v emacs) ]]; then
  read -r -n 1 -p "${CYAN}[>] Do you want to preview your image in Emacs? ${RESET}" input

  case "$input" in
    [yY])
      echo ""
      echo -e "${CYAN} Opening Emacs...${RESET}"
      emacs "$output_file"
    ;;
    [nN])
      exit 0
    ;;
    *)
      echo -e "${RED}[!] Incorrect input!${RESET}"
    ;;
  esac
fi
