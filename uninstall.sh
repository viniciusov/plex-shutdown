#!/bin/bash

echo 'Uninstalling...'

sudo rm -r /etc/plex-shutdown
sudo systemctl stop plex-shutdown.service
sudo systemctl disable plex-shutdown.service
sudo rm /etc/systemd/system/plex-shutdown.service

echo 'Done!'
