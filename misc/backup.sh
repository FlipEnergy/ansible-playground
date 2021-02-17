#!/bin/bash -e

# Run in WSL2

SOURCE_DIR='/mnt/d/Syncthing Data'
DEST_DIR='/mnt/e'



echo 'Archivy'
echo '========='
rsync -rP "${SOURCE_DIR%/}/Archivy Data/" "${DEST_DIR%/}/Archivy Data"

echo 'Bitwarden'
echo '========='
rsync -rP "${SOURCE_DIR%/}/bitwarden/" "${DEST_DIR%/}/bitwarden"

echo 'Camera'
echo '========='
rsync -rP "${SOURCE_DIR%/}/Camera/" "${DEST_DIR%/}/Pictures/Camera"

echo 'Clare'
echo '========='
rsync -rP "${SOURCE_DIR%/}/Clare/" "${DEST_DIR%/}/Clare"

echo 'Misc'
echo '========='
rsync -rP "${SOURCE_DIR%/}/Misc/" "${DEST_DIR%/}/Misc"

echo 'Wallpapers'
echo '========='
rsync -rP "${SOURCE_DIR%/}/Wallpapers/" "${DEST_DIR%/}/Pictures/Wallpapers"
