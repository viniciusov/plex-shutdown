#!/bin/bash

log_path=~/.config/plex-shutdown/log

echo --------------------------------------- >> $log_path
echo [$(date)] 'Started' >> $log_path
sleep 5s #wait for system initialization
proc_num=$(ps -aux | grep -c 'plexmediaserver') #number of plex processes right after startup
echo [$(date)] 'Initial Plex Processes:' $proc_num >> $log_path

while : ; do
	counter=0
	pending=false
	while [ $(ps -aux | grep -c 'plexmediaserver') -le $proc_num ] ; do #if plex is not running
		sleep 1m
		((counter++))
		if [ $counter -lt 50 ] && [ $(ps -aux | grep -c 'plexmediaserver') -gt $proc_num ] ; then #if plex start
			echo [$(date)] 'Plex Processes:' $(ps -aux | grep -c 'plexmediaserver') >> $log_path
			echo [$(date)] 'Plex activity detected. Restarting timer...' >> $log_path
			break
		elif [ $counter -eq 50 ] ; then #if not running until first 50 minutes, give a warning
			shut_time=$(date --date='10 minutes' +"%T")
			notify-send -t 600000 -i "/usr/share/plex-shutdown/plex.svg" "WARNING:
Plex is not transcoding.
Shutting down in 10 minutes ($shut_time).
Type shutdown -c in a terminal to cancel."
			sudo /sbin/shutdown -h +10
			pending=true
			echo [$(date)] 'Shutdown scheduled for' $shut_time  >> $log_path
		elif [ $counter -ge 60 ] ; then #it should shutdown the system
			sleep 10s #wait if system is shutting down
			echo [$(date)] 'TimeOver. Restarting timer...' >> $log_path
			notify-send -t 60000 -i "/usr/share/plex-shutdown/plex.svg" "Shutdown canceled by the system."
			break #pending=false before while loop
		fi
	done
	if $pending && [ $(ps -aux | grep -c 'plexmediaserver') -gt $proc_num ] ; then #if shutdown is pending and plex start
  		echo [$(date)] 'Plex Processes:' $(ps -aux | grep -c 'plexmediaserver') >> $log_path
		echo [$(date)] 'Shutdown canceled due Plex activity. Restarting timer...' >> $log_path
		sudo /sbin/shutdown -c
		notify-send -t 600000 -i "/usr/share/plex-shutdown/plex.svg" "Shutdown canceled due Plex activity."
	fi	
	sleep 1m
done
