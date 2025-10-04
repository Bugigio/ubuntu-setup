#!/bin/bash

set -e

echo "Starting setup..."

echo "Installing nala..."
sudo apt update
sudo apt install -y nala

# Function to install a package using nala
install_deb() {

}

echo "Installing other packages..."

sudo nala install -y git zsh curl wget neofetch eza bat starship cmake build-essential python3 python3-pip python3-venv ninja-build gdb gdbserver gnome-extensions gnome-tweaks

echo "Changing default shell to zsh..."
chsh -s $(which zsh)

echo "Installing brave browser..."
curl -fsS https://dl.brave.com/install.sh | sh

echo "Installing spotify and discord..."
sudo snap install spotify
sudo snap install discord