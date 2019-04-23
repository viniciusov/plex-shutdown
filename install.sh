#!/bin/bash

echo 'Installing...'

mkdir ~/.config/autostart
mkdir ~/.config/plex-shutdown
cp plex-shutdown.desktop ~/.config/autostart/

user=$USER
sudo bash -c 'echo "'$user' ALL=(ALL) NOPASSWD: /sbin/shutdown" > /etc/sudoers.d/shutdown'

sudo mkdir /usr/share/plex-shutdown
sudo cp plex-shutdown.sh /usr/share/plex-shutdown/
sudo cp plex.svg /usr/share/plex-shutdown/

echo 'Done!'
