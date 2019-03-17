#!/bin/bash

run_test () {
    processes=$(ps -aux | grep -c plex)
    if [ "$processes" -gt 6 ]; then
        return 0 #if plex is running
    else
        return 1 #if plex is not running
    fi
}

waiting () {
    sleep 60m
    run_test
}

while : ; do
	waiting
	
	while run_test ; do #if plex is running
	    waiting
	done
	
	shut_time=$(date --date='10 minutes' +"%T")
	notify-send -t 600000 -i "/usr/share/plex-shutdown/plex.svg" "WARNING:
	Plex is not running.
	Shutting down in 10 minutes (scheduled for $shut_time).
	Open the terminal and type shutdown -c to cancel."
	
	sudo /sbin/shutdown -h +10

	while ! run_test ; do #if plex is not running
		sleep 1m
		run_test
		if run_test ; then #if plex is running
			sudo /sbin/shutdown -c
			notify-send -t 600000 -i "/usr/share/plex-shutdown/plex.svg" "Shutdown Cancelled."
			break
		fi
	done 
done

