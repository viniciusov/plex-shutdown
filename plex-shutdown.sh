#!/bin/bash

while : ; do
	counter=0
	while [ $(ps -aux | grep -c 'plexmediaserver') -le 6 ] ; do #if plex is not running
		sleep 1m
		((counter++))
		if [ $counter -lt 50 ] ; then
			if [ $(ps -aux | grep -c 'plexmediaserver') -gt 6 ] ; then #if plex is running
				counter=0
			fi
		elif [ $counter -eq 50 ] ; then
			shut_time=$(date --date='10 minutes' +"%T")
			notify-send -t 600000 -i "/usr/share/plex-shutdown/plex.svg" "WARNING:
Plex is not transcoding.
Shutting down in 10 minutes ($shut_time).
Type shutdown -c in a terminal to cancel."
			sudo /sbin/shutdown -h +10
		else
			break
		fi
	done

	while [ $(ps -aux | grep -c 'plexmediaserver') -le 6 ] ; do #if plex is not running
		sleep 1m
		if [ $(ps -aux | grep -c 'plexmediaserver') -gt 6 ] || ! ps -C shutdown > /dev/null ; then #if plex is running or shutdown cancelled
			if ps -C shutdown > /dev/null ; then #if shutdown is still pending
  				sudo /sbin/shutdown -c
			fi
			notify-send -t 600000 -i "/usr/share/plex-shutdown/plex.svg" "Shutdown cancelled"
			break
		fi
	done 
done
