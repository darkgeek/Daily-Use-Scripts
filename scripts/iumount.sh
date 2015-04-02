#!/bin/sh

sudo umount /media/disk
success=$?

if [ $success -eq 0 ]; then
	echo "Remove USB Flash Successfully!"
else	
	echo "I'm Not Sure, But Maybe There's Something Wrong With Your Flash Currently. Please Check The Error Shown Previous To This Message."
fi	
