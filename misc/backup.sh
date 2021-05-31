#!/bin/bash -e

# Run in WSL2

mount_offsite() {
  mkdir -p /mnt/f
  mount -t drvfs F: /mnt/f
}

backup() {
  DEST_DIR=$1

  echo "Backing up to [$DEST_DIR]"

  echo 'Music...'
  echo '========='
  rsync -avh --delete '/mnt/c/Users/denni/Music/' "${DEST_DIR%/}/Music"

  echo 'Syncthing Data...'
  echo '========='
  rsync -avh --delete '/mnt/d/Syncthing Data' "${DEST_DIR%/}/Syncthing Data"
}

if [ "$EUID" -ne 0 ]
  then echo "Run as root!"
  exit 1
fi

case $1 in
  -c|--cold)
    mount_offsite
    backup /mnt/f
    ;;
  -w|--warm|*)
    backup /mnt/e
    ;;
esac
