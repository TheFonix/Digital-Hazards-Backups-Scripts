#!/bin/bash
#==============22/05/2017===============#
#Created By Fonix: https://fonix.online#
#Backup Script for moving files towards#
# a local backup system, solder edition#
#======================================#


#Load the spinner API
source "/home/spinner-repo/spinner.sh"


#Move towards the solder directory
start_spinner 'Moving to the directory of the Solder Repo'
cd /fs-data/solder/files/
        sleep 2
stop_spinner $?


#Zip the files inside of the current solder directory
start_spinner 'Zipping the files from the current Solder folder.'
        zip -r solder-mods-$(date +"%d-%m-%Y").zip mods > /dev/null
stop_spinner $?


#Move the ZIP file to the ownCloud REPO
start_spinner 'Moving the Zipped files to the Backup directory'
        mv *.zip /fs-data/solder/files/repo-backups
        sleep 1
stop_spinner $?


#Check that there is nothing older than 2 weeks in the directory
start_spinner 'Checking for files older than two weeks'
        find /fs-data/solder/files/repo-backups  -mtime +15 -exec rm {} \;
        sleep 3
stop_spinner $?

#Run OCC discovery
start_spinner 'Running Nextcloud Discovery for the user Solder'
	cd /home/nextcloud
        sudo -u www-data php occ files:scan --path=/solder > /dev/null
stop_spinner $?

#Rebuild ownership structures
start_spinner 'Rebuild ownership structures'
	cd /fs-data/solder
        chown -R www-data *
        sleep 3
stop_spinner $?

#Rebuild access structures
start_spinner 'Rebuild access structures'
        cd /fs-data/solder
        chmod -R 755 *
        sleep 3
stop_spinner $?


echo "╱╱╭╮"
        echo "╱╱┃┃"
                echo "╭━╯┣━━┳━╮╭━━╮"
                        echo "┃╭╮┃╭╮┃╭╮┫┃━┫"
                                echo "┃╰╯┃╰╯┃┃┃┃┃━┫"
                                        echo "╰━━┻━━┻╯╰┻━━╯"

