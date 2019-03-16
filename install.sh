#!/bin/bash

echo 'Installing...'

user=$USER
sudo bash -c 'echo "'$user' ALL=(ALL) NOPASSWD: /sbin/shutdown" > /etc/sudoers.d/shutdown'

chmod 777 *.sh
sudo mkdir /usr/share/plex-shutdown
sudo cp plex-shutdown.sh /usr/share/plex-shutdown/
sudo cp plex.svg /usr/share/plex-shutdown/
sudo cp plex-shutdown.desktop ~/.config/autostart/

echo 'Done!'
