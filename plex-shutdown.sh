#!/bin/bash

run_test () {
    processes=$(ps -aux | grep -c plex)
    if [ "$processes" -gt 6 ]; then
        return 0
    else
        return 1
    fi
}

waiting () {
    sleep 60m
    run_test
}

waiting

while run_test 
do
    waiting
done

shut_time=$(date --date='10 minutes' +"%T")
notify-send -t 600000 -i "/usr/share/plex-shutdown/plex.svg" "WARNING:
Plex is not running.
Shutting down in 10 minutes (scheduled for $shut_time).
Open the terminal and type shutdown -c to cancel."

sudo /sbin/shutdown -h +10