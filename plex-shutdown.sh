#!/bin/bash

while : ; do
	counter=0
	while [ $(ps -aux | grep -c 'Plex Transcoder') -le 1 ] ; do #if plex is not running
		sleep 1m
		((counter++))
		if [ $counter -lt 50 ] ; then
			if [ $(ps -aux | grep -c 'Plex Transcoder') -gt 1 ] ; then #if plex is running
				counter=0
			fi
		else
			break
		fi
	done
	
	shut_time=$(date --date='10 minutes' +"%T")
	notify-send -t 600000 -i "/usr/share/plex-shutdown/plex.svg" "WARNING:
Plex is not transcoding.
Shutting down in 10 minutes (scheduled for $shut_time).
Open the terminal and type shutdown -c to cancel."
	
	sudo /sbin/shutdown -h +10

	while [ $(ps -aux | grep -c 'Plex Transcoder') -le 1 ] ; do #if plex is not running
		sleep 1m
		if [ $(ps -aux | grep -c 'Plex Transcoder') -gt 1 ] || ! [ -f /run/systemd/shutdown/scheduled ] ; then #if plex is running or shutdown cancelled
			sudo /sbin/shutdown -c
			notify-send -t 600000 -i "/usr/share/plex-shutdown/plex.svg" "Shutdown cancelled"
			break
		fi
	done 
done

