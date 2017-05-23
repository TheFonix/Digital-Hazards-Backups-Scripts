#!/bin/bash
#==============22/05/2017===============#
#Created By Fonix: https://fonix.online#
#Backup Script for moving files towards#
# a local backup system, solder edition#
#======================================#


#Load the spinner API
source "/home/spinner-repo/spinner.sh"

NODE="dh-mh-01"
SERVER="crafti_03eeddcc"

#Start the script by saying hi there!
echo ""
echo ""
echo "-------------------------------------------"
echo "Hi! My names $SERVER Nice to meet you! <3"
echo "-------------------------------------------"
echo ""
echo ""
sleep 5

#Move towards the Server directory
start_spinner 'Moving to the directory of the Daemon Server Target and building files if needed'
mkdir -p /fs-data/backups/files/$SERVER/rsync_temp && cd /fs-data/backups/files/$SERVER/rsync_temp
        sleep 2
stop_spinner $?


#Start the RSYNC
start_spinner 'RSYNC started from Server Location'
        rsync -avz -P $NODE:/srv/daemon-data/$SERVER/data/* /fs-data/backups/files/$SERVER/rsync_temp > /dev/null
stop_spinner $?

#ZIP the Rsync'ed Files
start_spinner 'Zipping files from the IONODE transfer'
        zip -r $SERVER-backup-$(date +"%d-%m-%Y").zip * > /dev/null
        sleep 1
stop_spinner $?

#Move files back a directory
start_spinner 'Moving files back a directory'
        mv *.zip /fs-data/backups/files/$SERVER
        sleep 3
stop_spinner $?

#Check that there is nothing older than a two week in the directory
start_spinner 'Checking for files older than two weeks'
        find /fs-data/backups/files/$SERVER/*.zip  -mtime +14 -exec rm {} \;
        sleep 3
stop_spinner $?

#Rebuild ownership structures
start_spinner 'Rebuild ownership structures'
        cd /fs-data/backups/files/$SERVER
        chown -R www-data *
        sleep 3
stop_spinner $?

#Rebuild access structures
start_spinner 'Rebuild access structures'
        cd /fs-data/backups/files/$SERVER
        chmod -R 755 *
        sleep 3
stop_spinner $?

#Rebuild access structures
start_spinner 'Clear up RAW files'
        rm -rf  /fs-data/backups/files/$SERVER/rsync_temp/*
        sleep 3
stop_spinner $?

#Run OCC discovery
start_spinner 'Running Nextcloud Discovery for the user backups'
        cd /home/nextcloud
        sudo -u www-data php occ files:scan --path=/backups > /dev/null
stop_spinner $?

echo "╱╱╭╮"
        echo "╱╱┃┃"
                echo "╭━╯┣━━┳━╮╭━━╮"
                        echo "┃╭╮┃╭╮┃╭╮┫┃━┫"
                                echo "┃╰╯┃╰╯┃┃┃┃┃━┫"
                                        echo "╰━━┻━━┻╯╰┻━━╯"
