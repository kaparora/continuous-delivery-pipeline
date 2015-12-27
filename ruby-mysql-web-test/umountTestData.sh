#!/bin/bash
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi


echo "Reading config...."
source database.config
echo "VOLUME: $VOLUME"
echo "MOUNT_AT: $MOUNT_AT"
echo "Umount volume"
umount $MOUNT_AT
