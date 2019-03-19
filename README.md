# Plex-Shutdown
It automatically shuts down your PC if Plex were not transcoding within 1 hour.

## How it works
It will monitor your computer processes to check if Plex is transcoding or not.  
If Plex weren't transcoding within 50 minutes, it will send a pop-up notification to your main screen, warning about a pending shutdown for the next 10 minutes.  

![Notification preview](https://raw.githubusercontent.com/viniciusov/plex-shutdown/master/sample_images/1.png)

After the warning, if plex starts transcoding or if you cancel the shutdown by typing `shutdown -c` in a terminal, you will see a new pop-up about the cancelation.  

## Requirements
- Linux OS
- notify-send (you should already have this installed in your OS but maybe there is a Linux distro without it, so it' just a matter of installing this to get the pop-up notifications)

## Installation
- Open a terminal;
- Go the plex-shutdown folder;
- And type `./installer.sh` (you **must** run this as a non-root user, **without sudo**)

## License
This project is under GPLv3 (see https://www.gnu.org/licenses/gpl-3.0.de.html for more details).  
I have no relation with the original Plex application, and this is intend to be just a free and independent add-on.  
The Plex logo is from the Antü Plasma Suite, by Fabián Alex.

## Contact
viniciusov@hotmail.com
