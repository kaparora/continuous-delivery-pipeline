#!/bin/bash
echo "Reading config...."
source database.config
echo "HOST: $HOST" 
echo "VOLUME_PROD: $VOLUME_PROD"
echo "VOLUME_CLONE_NAME: $VOLUME_CLONE_NAME"
echo "MOUNT_AT: $MOUNT_AT"
echo "MYSQL_PASSWORD: $MYSQL_PASSWORD"
echo "STORGAE_HOST: $STORGAE_HOST"
echo "STORGAE_USER: $STORGAE_USER"
echo "STORAGE_PASSWORD: $STORAGE_PASSWORD"
cd netapp_sdk
echo "deleting existing clone"
if ruby flexClone.rb $STORGAE_HOST $STORGAE_USER $STORAGE_PASSWORD delete $VOLUME_CLONE_NAME;then
echo "deleted"
else 
echo "delete failed"
fi
echo "creating new clone"
ruby flexClone.rb $STORGAE_HOST $STORGAE_USER $STORAGE_PASSWORD create $VOLUME_CLONE_NAME $VOLUME_PROD
