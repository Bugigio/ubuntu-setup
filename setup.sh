#!/bin/bash

set -e

echo "Starting setup..."

echo "Installing nala..."
sudo apt update
sudo apt install -y nala

echo "Installing other packages..."

sudo nala install -y git zsh curl wget neofetch eza bat cmake build-essential python3 python3-pip python3-venv ninja-build gdb gdbserver gnome-tweaks

echo "Changing default shell to zsh..."
chsh -s $(which zsh)

echo "Installing brave browser..."
curl -fsS https://dl.brave.com/install.sh | sh

echo "Installing spotify and discord..."
sudo snap install spotify
sudo snap install discord

echo "Installing visual studio code..."
wget -c --progress=bar -O vscode.deb 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64'
sudo nala install -y ./vscode.deb
rm -rf vscode.deb

echo "Installing kitty terminal..."
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
sudo ln -s ~/.local/kitty.app/bin/kitty /usr/local/bin/
sudo ln -s ~/.local/kitty.app/bin/kitten /usr/local/bin/
echo "[Desktop Entry]
		Version=1.0
		Type=Application
		Name=Kitty Terminal
		GenericName=Terminal Emulator
		Comment=Fast, feature-rich, GPU based terminal emulator
		Exec=kitty
		Icon=kitty
		Categories=System;TerminalEmulator;
		Keywords=terminal;emulator;shell;command;command-line;
		StartupNotify=true
		StartupWMClass=kitty" | sudo tee /usr/share/applications/kitty.desktop
mkdir -p ~/.local/share/icons
cp ~/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png ~/.local/share/icons/
update-desktop-database ~/.local/share/applications/
cp ./current-theme.conf ~/.config/kitty/current-theme.conf
cp ./kitty.conf ~/.config/kitty/kitty.conf

echo "Installing starship prompt..."
curl -sS https://starship.rs/install.sh | sh

echo "Installing jdk latest..."
mkdir -p ~/.local/java
# This will get the latest JDK 25 build
wget -O jdk-25-latest.tar.gz 'https://api.adoptium.net/v3/binary/latest/25/ga/linux/x64/jdk/hotspot/normal/eclipse'
tar -xzf jdk-25-latest.tar.gz -C ./
mv ./jdk-25* ~/.local/java/
rm -rf jdk-25-latest.tar.gz

# echo "Installing ghidra..."
# wget -O ghidra.zip "https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_11.4.2_build/ghidra_11.4.2_PUBLIC_20250826.zip"
# unzip ghidra.zip -d ~/
# rm -rf ghidra.zip

echo "Setting up python venv..."
python3 -m venv ~/.py-venv
source ~/.py-venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt
deactivate

echo "Installing pwndbg..."
git clone https://github.com/pwndbg/pwndbg && ./pwndbg/setup.sh

# echo "Installing patchelf..."
# git clone 
# mkdir build
# cd build
# cmake .. -GNinja
# ninja all
# sudo ninja install

echo "Installing rust..."
curl https://sh.rustup.rs -sSf | sh

echo "Installing cargo packages..."
source "$HOME/.cargo/env"
rustup toolchain install beta
sudo nala update
sudo nala install liblzma-dev pkg-config build-essential libssl-dev elfutils
cargo install pwinit

echo "Setting up printer drivers..."
sudo nala install -y epson-inkjet.deb epson-printer.deb

echo "Make sure also to install ghidra and patchelf manually if you want to use them."
echo "https://github.com/NixOS/patchelf"
echo "https://github.com/NationalSecurityAgency/ghidra/releases/"

echo "Install manually these fonts zips: FiraMono.zip, JetBrains_Mono.zip, Meslo.zip and then run fonts.sh"


echo "Setup complete! Please restart your terminal."
