#!/bin/bash

#Want to run all of the backups scripts? Cool Story <3 Run me then!

cd /home/Backup-Routine/per-server-backups

for f in *.sh; do
  bash "$f" -H   || break
done
