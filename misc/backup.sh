#!/bin/bash -e

# Run in WSL2

DEST_DIR='/mnt/e'

echo "Backing up to [$DEST_DIR]"

echo 'Music...'
echo '========='
rsync -avh --delete '/mnt/c/Users/denni/Music/' "${DEST_DIR%/}/Music"

echo 'Syncthing Data...'
echo '========='
rsync -avh --delete '/mnt/d/Syncthing Data' "${DEST_DIR%/}/Syncthing Data"
