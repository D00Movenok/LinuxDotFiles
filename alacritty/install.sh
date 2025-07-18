#!/bin/bash

script_dir=$(dirname $(readlink -f "$0"))

sudo apt install -y alacritty

# install alacritty config
rm -rf ${HOME}/.config/alacritty
ln -sv ${script_dir}/ ${HOME}/.config/alacritty

# add theme
git clone https://github.com/alacritty/alacritty-theme themes

# update default terminal for systems that uses x-terminal-emulator
sudo update-alternatives --set x-terminal-emulator /usr/bin/alacritty

# update default terminal for systems that uses xdg-terminal-exec
# (e.g. ubuntu 25.04)
if [ -f /usr/share/applications/Alacritty.desktop ]; then
    alacritty_desktop="Alacritty.desktop"
else
    echo "Alacritty desktop file not found in /usr/share/applications/"
    exit 1
fi
find "$HOME" -type f -name '*xdg-terminals.list' | while read -r file; do
    if ! grep -q "$alacritty_desktop" "$file"; then
        sed -i "1i$alacritty_desktop" "$file"
    fi
done
