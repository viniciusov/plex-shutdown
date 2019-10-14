# Plex-Shutdown
A simple script to automatically shutdown your PC if your Plex Server isn't sharing any media within 1 hour.

## How it works
After you **log in**, this script will monitor your computer processes to check if your Plex Server is transcoding or not.  
If it's not transcoding, it will also monitor the upload rates to check if the Plex Server is uploading any content (if you don't want to monitor your upload rates, check the branch [*transcoding-only*](https://github.com/viniciusov/plex-shutdown/tree/transcoding-only)).  

## Requirements
- Linux OS

## Installation
- Open a terminal;
- Clone this git repository: `git clone https://github.com/viniciusov/plex-shutdown` (or simply download as .ZIP file and extract it);
- Go the plex-shutdown folder: `cd plex-shutdown`;
- Type `sudo ./install.sh` to run the installer;
- Insert your root password when prompted;

## Uninstallation
- Go to the plex-shutdown folder and run `sudo ./uninstall.sh`;
- Insert your root password when prompted.

## License
This project is under the GPLv3 License (see https://www.gnu.org/licenses/gpl-3.0.de.html for more details).  
I have no relation with the original Plex application, and this is intend to be just a free and independent add-on.  

## Contact
If you have any doubt, suggestion or want to contact me, use my email viniciusov@hotmail.com.
