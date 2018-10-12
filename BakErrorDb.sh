#! /bin/bash

cd /home/SqlBak/
FileName=$1
DATE=`date +20%y%m%d`
SQLNAME="$FileName"_"$DATE".sql

mysqldump -u root -p123456 m1database > $SQLNAME 
