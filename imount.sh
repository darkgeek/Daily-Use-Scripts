#!/bin/sh

uname -a | grep -i linux > /dev/null
is_linux=$?

if [ $is_linux -eq 0 ]; then
	ls /dev/sdb1 > /dev/null 2>&1
	have_slice=$?
	MOUNT_CMD_SLICE="sudo mount /dev/sdb1 /media/disk -o utf8,umask=000"
	MOUNT_CMD_NO_SLICE="sudo mount /dev/sdb /media/disk -o utf8,umask=000"
else
	ls /dev/da0s1 > /dev/null 2>&1
	have_slice=$?
	MOUNT_CMD_SLICE="sudo mount_msdosfs -m 777 -L zh_CN.UTF-8 /dev/da0s1 /media/disk"
	MOUNT_CMD_NO_SLICE="sudo mount_msdosfs -m 777 -L zh_CN.UTF-8 /dev/da0 /media/disk" 
fi

if [ $have_slice -eq 0 ]; then
	$MOUNT_CMD_SLICE
	if [ $? -eq 0 ]; then 
		echo "Mount USB Flash Drive Successfully!" 
	else
		echo "An Error Interupted Me!"
	fi	
else
	$MOUNT_CMD_NO_SLICE
	if [ $? -eq 0 ]; then 
		echo "Mount USB Flash Drive Successfully!"
	else
		echo "An Error Interupted Me!"
	fi	

fi
