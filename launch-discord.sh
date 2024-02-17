#!/bin/bash

installPath="/opt/discord"
launcherPath="/opt/discord-launcher"
linkPath="/usr/share/discord"
packageName="discord.tar.gz"
tempPath="/tmp/discord_install"
downloadPath="https://discord.com/api/download?platform=linux&format=tar.gz"
applicationsPath="/usr/share/applications"
shortcutFilePath="$launcherPath/discord.desktop"
desktopFilePath="$installPath/discord.desktop"
versionFilePath="$installPath/version.txt"

version=$(wget --spider -nv -O /dev/stdout "https://discord.com/api/download?platform=linux&format=tar.gz" 2>&1 | grep -o -P '(?<=URL: ).*?(?=200)')

if [ "$UID" -eq 0 ]; then

    if test -d $tempPath; then
        rm -rf $tempPath
    fi

    if test -d $installPath; then
        rm -rf $installPath
    fi

    if test -d $linkPath; then
        rm -rf $linkPath
    fi

    mkdir $tempPath
    mkdir $installPath
    wget -O $tempPath/$packageName $downloadPath
    tar -xzvf $tempPath/$packageName --strip-components=1 -C $installPath
    cp $shortcutFilePath $applicationsPath
    ln -s $installPath $linkPath
    echo $version > $versionFilePath
    rm -rf $tempPath

    exec runuser -u $SUDO_USER bash "$0"

else

    echo "Checking if Discord is up to date."

        if ! [[ -f $versionFilePath && $(grep -c $version $versionFilePath) -eq 1 ]]; then
            echo "Discord is out of date, rerunning script as root and updating."
            exec sudo bash "$0" &

        else

            echo "Discord is up to date, launching."
            gio launch $desktopFilePath &>/dev/null
            exit
        fi

fi


