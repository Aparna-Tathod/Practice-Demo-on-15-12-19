#!/bin/bash

echo " Enter your Access Key "
read accesskey 
echo " Enter your Secrete Access Key "
read secret 
echo "enter the bucket that you need backup in "
read bucket
echo "enter the backup folder full path "
read sourcepath
export AWS_ACCESS_KEY_ID=$accesskey
export AWS_SECRET_ACCESS_KEY=$secret
export AWS_DEFAULT_REGION=ap-south-1
aws s3 cp $sourcepath s3://$bucket/backup/ --recursive
if [ $? -eq 0 ]
then
echo "backup successful"
else
echo "backup failed , check your inputs "
fi
