#!/bin/bash

while : ; do
	sleep 60m
	
	while [ $(ps -aux | grep -c plex) -gt 6 ] ; do #if plex is running
		sleep 60m
	done
	
	shut_time=$(date --date='10 minutes' +"%T")
	notify-send -t 600000 -i "/usr/share/plex-shutdown/plex.svg" "WARNING:
	Plex is not running.
	Shutting down in 10 minutes (scheduled for $shut_time).
	Open the terminal and type shutdown -c to cancel."
	
	sudo /sbin/shutdown -h +10

	while [ $(ps -aux | grep -c plex) -lt 6 ] ; do #if plex is not running
		sleep 1m
		if [ $(ps -aux | grep -c plex) -gt 6 ] ; then #if plex is running
			sudo /sbin/shutdown -c
			notify-send -t 600000 -i "/usr/share/plex-shutdown/plex.svg" "Shutdown Cancelled."
			break
		fi
	done 
done

