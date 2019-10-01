#!/bin/bash
mkdir -p ~/.config
chmod +x ~/dotfiles/config/i3/*.sh
ln -s ~/dotfiles/config/* ~/.config
ln -s ~/.i3blocks.conf ~/
ln -s ~/.gtkrc-2.0 ~/
