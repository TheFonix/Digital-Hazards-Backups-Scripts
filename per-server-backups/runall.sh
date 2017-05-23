#!/bin/bash

#Want to run all of the backups scripts? Cool Story <3 Run me then!

for f in *.sh; do
  bash "$f" -H   || break
done
