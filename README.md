The purpose of this script is to automate installing, updating and launching Discord on Linux. Mainly an excercise for me to learn Bash scripting in practice. Designed for my personal use in a Debian/KDE environment, but should work with other distributions too. I may continue improving it, comments are welcome.

Usage: Place script in /opt/discord-launcher and run it as a regular user when you wish to launch Discord.
-If Discord is installed and up to date, Discord will simply be launched.
-If Discord is not installed or is out of date, the script will relaunch itself and prompt for root privileges, download and install Discord, then relaunch itself again as a regular user and proceed to launch Discord.

