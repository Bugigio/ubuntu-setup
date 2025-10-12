#!/bin/bash

set -e

if ! [ -f $1 ]; then
	echo "Usage: $0 <path-to-fonts.zip>"
	exit 1
fi

echo "Installing fonts from $1..."
mkdir -p ~/.local/share/fonts
unzip -o $1 -d ~/.local/share/fonts
fc-cache -fv
echo "Fonts installed successfully."
