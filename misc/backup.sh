#!/bin/bash -e

# Run in WSL2

usage() {
  echo "${0} [options]"
  echo "options:"
  echo "  -c,--cold    back up to cold storage (offsite)"
  echo "  -w,--warm    back up to warm storage (External HDD)"
  echo "  -h,--help    show this help message"
}

mount_offsite() {
  mkdir -p /mnt/f
  mount -t drvfs F: /mnt/f
}

backup() {
  DEST_DIR=$1
  OPTIONS=$2

  echo "Backing up to [$DEST_DIR]"

  echo 'Music...'
  echo '========='
  set -x
  rsync -avh --delete ${OPTIONS} '/mnt/c/Users/denni/Music/' "${DEST_DIR%/}/Music"
  set +x

  echo 'Syncthing Data...'
  echo '========='
  set -x
  rsync -avh --delete ${OPTIONS} '/mnt/d/Syncthing Data' "${DEST_DIR%/}/Syncthing Data"
  set +x
}

if [ "$EUID" -ne 0 ]
  then echo "Run as root!"
  exit 1
fi

case $1 in
  -c|--cold)
    mount_offsite
    backup /mnt/f '--exclude Clare'
    ;;
  -w|--warm)
    backup /mnt/e
    ;;
  -h|--help|*)
    usage
    ;;
esac
