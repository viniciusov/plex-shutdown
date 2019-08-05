# Plex-Shutdown
A simple script to automatically shutdown your PC if Plex is not transcoding within 1 hour.

## How it works
This script will monitor your computer processes to check if Plex is transcoding or not.  
If Plex isn't transcoding for a long time, it will send a pop-up notification to your main screen warning about a pending shutdown for the next 10 minutes.  

![Notification preview](https://raw.githubusercontent.com/viniciusov/plex-shutdown/master/sample_images/1.png)

After the warning, if plex starts transcoding or if you type `shutdown -c` in a terminal, the shutdown will be canceled.  

## Requirements
- Linux OS
- notify-send (you should already have this installed in your OS but maybe there is a Linux distro without it, so it's just a matter of installing this to get the pop-up notifications)

## Installation
- Open a terminal;
- Clone this git repository: `git clone https://github.com/viniciusov/plex-shutdown` (or simply download as .ZIP file and extract it);
- Go the plex-shutdown folder: `cd plex-shutdown`;
- Type `./install.sh` to run the installer (you **must** run this as a non-root user, **without sudo**);
- Insert your root password when prompted;
- Reboot or LogOUT/LogIN to the main script starts running.

## Uninstallation
- Go to the plex-shutdown folder and run `./uninstall.sh`;
- Insert your root password when prompted.

## Timing issues
This script works monitoring the active plex processes. However, it's very hard to predict wich plex process will be active and how long it will stay running (some of them may be related to updates or other tasks).   
So, when you start your OS, there may be some of these active processes and they will stay active for an undefined period. The result is that the plex-shutdown can't schedule a shutdown after a very defined time (although it is set to schedule after 50 minutes of inactivity).  
In my tests this inactivity time until it schedule a shutdown (for the next 10 minutes) was around 90 minutes, wich is pretty good but not always the same.

## License
This project is under the GPLv3 License (see https://www.gnu.org/licenses/gpl-3.0.de.html for more details).  
I have no relation with the original Plex application, and this is intend to be just a free and independent add-on.  
The Plex icon (used in the notification pop-ups) is from the Antü Classic, by Fabián Alex, released under LGPL 2.1 License (see https://github.com/fabianalexisinostroza/Antu-classic/blob/master/LICENSE.md for more details).

## Contact
If you have any doubt, suggestion or want to contact me, use my email viniciusov@hotmail.com.
