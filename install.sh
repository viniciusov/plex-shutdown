#!/bin/bash

echo 'Installing...'

sudo mkdir /etc/plex-shutdown
sudo cp plex-shutdown.sh /etc/plex-shutdown/
sudo cp plex-shutdown.service /etc/systemd/system/
sudo systemctl enable plex-shutdown.service
sudo systemctl start plex-shutdown.service

echo 'Done!'
