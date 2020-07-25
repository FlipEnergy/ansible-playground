#!/bin/bash

echo "=========="
echo

echo "Backing up Bitwarden..."
date
rsync -rog --delete --exclude=.stfolder --chown=dennis:dennis /mnt/bitwarden /mnt/syncthing-data/
echo "Done"
echo

date
echo
