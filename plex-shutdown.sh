#!/bin/bash

########################################
# Configuration:

log_path=~/.config/plex-shutdown/log
up_trigger=1000 #bytes
idle_time=50 #minutes
warning_time=10 #minutes

########################################

shutdown_time=$(($idle_time + $warning_time))
proc_num=$(($(ps -aux | grep -c 'plexmediaserver')+1))
sleep 10s #for system initialization (and connect to the internet)
interface=$(route | awk 'END {print $NF}')

echo --------------------------------------- >> $log_path
echo [$(date)] 'Started' >> $log_path
echo [$(date)] 'Initial Plex Processes:' $proc_num >> $log_path
echo [$(date)] 'Monitoring Interface:' $interface >> $log_path

while : ; do
	counter=0
	pending=false
	
	upload1=$(cat /proc/net/dev | grep $interface | awk '{print $2}')
	sleep 10s
	upload2=$(cat /proc/net/dev | grep $interface | awk '{print $2}')
	upload=$((($upload2 - $upload1)/10)) #check upload rate (average)

	while [ $(ps -aux | grep -c 'plexmediaserver') -le $proc_num ] && [ $upload -le $up_trigger ] ; do #if plex is not running

		sleep 50s
		((counter++))

		upload1=$(cat /proc/net/dev | grep $interface | awk '{print $2}')
		sleep 10s
		upload2=$(cat /proc/net/dev | grep $interface | awk '{print $2}')
		upload=$((($upload2 - $upload1)/10)) #check upload rate (average)

		if [ $counter -lt $idle_time ] && [ $(ps -aux | grep -c 'plexmediaserver') -gt $proc_num ] ; then #if plex start
			echo [$(date)] 'Counter:' $counter >> $log_path
			echo [$(date)] 'Plex Processes:' $(ps -aux | grep -c 'plexmediaserver') >> $log_path
			echo [$(date)] 'Plex activity detected. Restarting timer...' >> $log_path
			break		
		elif [ $counter -lt $idle_time ] && [ $upload -gt $up_trigger ] ; then
			echo [$(date)] 'Counter:' $counter >> $log_path
			echo [$(date)] 'Current upload rate (bytes/s):' $upload >> $log_path
			echo [$(date)] 'Uploading content. Restarting timer...' >> $log_path
			break
		elif [ $counter -eq $idle_time ] ; then #if not running until 'idle_time', give a warning
			shut_time=$(date --date='10 minutes' +"%T")
			notify-send -t $(($warning_time*60*1000)) -i "/usr/share/plex-shutdown/plex.svg" "WARNING:
Plex is not running.
Shutting down in $warning_time minutes ($shut_time).
Type shutdown -c in a terminal to cancel."
			sudo /sbin/shutdown -h +$warning_time
			pending=true
			echo [$(date)] 'Counter:' $counter >> $log_path
			echo [$(date)] 'Shutdown scheduled for' $shut_time  >> $log_path
		elif [ $counter -ge $shutdown_time ] ; then #it should shutdown the system
			sleep 10s #wait if system is shutting down
			echo [$(date)] 'Counter:' $counter >> $log_path
			echo [$(date)] 'Time Over. Restarting timer...' >> $log_path
			notify-send -t $(($warning_time*60*1000)) -i "/usr/share/plex-shutdown/plex.svg" "Shutdown canceled by the system."
			break #pending=false before while loop
		fi
	done

	if $pending ; then

		upload1=$(cat /proc/net/dev | grep $interface | awk '{print $2}')
		sleep 10s
		upload2=$(cat /proc/net/dev | grep $interface | awk '{print $2}')
		upload=$((($upload2 - $upload1)/10)) #check upload rate (average)

		if [ $(ps -aux | grep -c 'plexmediaserver') -gt $proc_num ] ; then #if shutdown is pending and plex start
			echo [$(date)] 'Counter:' $counter >> $log_path
			echo [$(date)] 'Plex Processes:' $(ps -aux | grep -c 'plexmediaserver') >> $log_path
			echo [$(date)] 'Shutdown canceled due Plex activity. Restarting timer...' >> $log_path
			sudo /sbin/shutdown -c
			notify-send -t $(($warning_time*60*1000)) -i "/usr/share/plex-shutdown/plex.svg" "Shutdown canceled."
		elif [ $upload -gt $up_tigger ] ; then
			echo [$(date)] 'Counter:' $counter >> $log_path
			echo [$(date)] 'Current upload rate (bytes/s):' $upload >> $log_path
			echo [$(date)] 'Shutdown canclede due upload. Restarting timer...' >> $log_path
			sudo /sbin/shutdown -c
			notify-send -t $(($warning_time*60*1000)) -i "/usr/share/plex-shutdown/plex.svg" "Shutdown canceled."
		fi 
	fi	
	sleep 1m
done
