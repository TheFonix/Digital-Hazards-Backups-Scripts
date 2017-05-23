#!/bin/sh
echo "Running start all scripts! <3"

cd /home/Backup-Routine

cd local-backups
./solder-backup.sh
cd ..
echo "local-backup complete"
sleep 1

cd per-server-backups
./*.sh
cd ..
echo "per server backups complete"
sleep 1

cd whole-server-backups
./*.sh
cd ..
echo "whole backups complete"
sleep 1

cd whole-vm-backups
./*.sh
cd ..
echo "whole vm backups complete"
sleep 1


echo "All files complete"
