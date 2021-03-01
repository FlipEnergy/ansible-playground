#!/bin/bash -e

# Run in WSL2

SOURCE_DIR='/mnt/d/Syncthing Data'
DEST_DIR='/mnt/e/Syncthing Data'

echo 'Music...'
echo '========='
rsync -rP '/mnt/c/Users/denni/Music/' '/mnt/e/Music'

echo 'Syncthing Data...'
echo '========='
rsync -rP "${SOURCE_DIR%/}/" "${DEST_DIR}"
