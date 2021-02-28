#!/bin/bash -e

# Run in WSL2

SOURCE_DIR='/mnt/d/Syncthing Data'
DEST_DIR='/mnt/e/Syncthing Data'


echo 'Syncing...'
echo '========='
rsync -rP "${SOURCE_DIR%/}/" "${DEST_DIR}"
