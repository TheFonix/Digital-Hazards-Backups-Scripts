#!/bin/bash
#==============22/05/2017===============#
#Created By Fonix: https://fonix.online#
#Backup Script for moving files towards#
# a local backup system, solder edition#
#======================================#


#Load the spinner API
source "/home/backup-scripts/spinner-repo/spinner.sh"

IONODE="dh-io-06"
IONODEBACKUP="dh-io-6-backups"

#Move towards the NODE directory
start_spinner 'Moving to the directory of the IO Target'
cd /fs-data/backups/files/$IONODEBACKUP/rsync_temp
        sleep 2
stop_spinner $?


#Start the RSYNC
start_spinner 'RSYNCing files from IONODE'
        rsync -avz -P $IONODE:/root/ /fs-data/backups/files/$IONODEBACKUP/rsync_temp > /dev/null
stop_spinner $?

#ZIP the Rsync'ed Files
start_spinner 'Zipping files from the IONODE transfer'
        zip -r $IONODE-$(date +"%d-%m-%Y").zip * > /dev/null
        sleep 1
stop_spinner $?

#Move files back a directory
start_spinner 'Moving files back a directory'
        mv *.zip /fs-data/backups/files/$IONODEBACKUP
        sleep 3
stop_spinner $?

#Check that there is nothing older than a week in the directory
start_spinner 'Checking for files older than a week'
        find /fs-data/backups/files/$IONODEBACKUP/*.zip  -mtime +7 -exec rm {} \;
        sleep 3
stop_spinner $?

#Rebuild ownership structures
start_spinner 'Rebuild ownership structures'
        cd /fs-data/backups/files/$IONODEBACKUP
        chown -R www-data *
        sleep 3
stop_spinner $?

#Rebuild access structures
start_spinner 'Rebuild access structures'
        cd /fs-data/backups/files/$IONODEBACKUP
        chmod -R 755 *
        sleep 3
stop_spinner $?

#Rebuild access structures
start_spinner 'Clear up RAW files'
        rm -rf  /fs-data/backups/files/$IONODEBACKUP/rsync_temp/*
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
