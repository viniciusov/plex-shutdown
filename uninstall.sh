#!/bin/bash

echo 'Uninstalling...'

rm  ~/.config/autostart/plex-shutdown.desktop
sudo rm -r /usr/share/plex-shutdown

echo 'Done!'
