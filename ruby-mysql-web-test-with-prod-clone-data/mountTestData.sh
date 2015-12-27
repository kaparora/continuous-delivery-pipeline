#!/bin/bash
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi
echo "Reading config...."
source database.config
echo "HOST: $HOST"
echo "VOLUME_PROD: $VOLUME_PROD"
echo "VOLUME_CLONE_NAME: $VOLUME_CLONE_NAME"
echo "MOUNT_AT: $MOUNT_AT" 
echo "creating $MOUNT_AT dir if not exist already"
mkdir -p $MOUNT_AT
echo "trying Umount volume"
umount $MOUNT_AT
echo "Mounting volume $HOST:/$VOLUME_CLONE_NAME at location $MOUNT_AT"
mount -t nfs $HOST:/$VOLUME_CLONE_NAME $MOUNT_AT
