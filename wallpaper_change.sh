#!/bin/bash

DIR="$HOME/Immagini/wallpapers"

export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u)/bus
export XDG_RUNTIME_DIR=/run/user/$(id -u)

FILE=$(ls "$DIR" | shuf -n 1)

gsettings set org.gnome.desktop.background picture-uri-dark "file://$DIR/$FILE"
