#!/bin/bash
result=`find /root/tera-server-local/ -name "*.log" | grep "Logs"`
downfile=`find /root/tera-server-local/ -name "*.log" | grep "Logs" | grep -v '\\\\'`
tar cvf serverlog.tar.gz $downfile
sz serverlog.tar.gz
rm serverlog.tar.gz
