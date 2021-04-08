#!/bin/bash
mkdir -p ~/.config
chmod +x ~/dotfiles/config/i3/*.sh
chmod +x ~/dotfiles/config/i3blocks/*.sh
ln -s ~/dotfiles/config/* ~/.config
ln -s ~/dotfiles/.i3blocks.conf ~/
ln -s ~/dotfiles/.gtkrc-2.0 ~/
