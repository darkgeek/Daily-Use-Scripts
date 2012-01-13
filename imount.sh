#!/bin/sh

ls /dev/da0s1 > /dev/null 2>&1
have_slice=$?

if [ $have_slice -eq 0 ]; then
	sudo mount_msdosfs -m 777 -L zh_CN.GBK /dev/da0s1 /media/disk 
	if [ $? -eq 0 ]; then 
		echo "Mount USB Flash Drive Successfully!" && thunar /media/disk
	else
		echo "An Error Interupted Me!"
	fi	
else
	sudo mount_msdosfs -m 777 -L zh_CN.GBK /dev/da0 /media/disk 
	if [ $? -eq 0 ]; then 
		echo "Mount USB Flash Drive Successfully!" && thunar /media/disk
	else
		echo "An Error Interupted Me!"
	fi	

fi
