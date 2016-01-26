#!/bin/bash
echo Mount /proc...
mount -t proc none /proc && echo Done.

echo Mount /sys...
mount -t sysfs none /sys && echo Done.

echo Mount /dev...
mount -o bind /dev /dev && echo Done.

echo Mount /dev/pts...
mount -t devpts none /dev/pts && echo Done.

# Start SSHD
echo Check if sshd is running...
/etc/init.d/ssh status
if [ $? -ne 0 ]; then
    echo Well, looks not running, so start SSHD...
    /etc/init.d/ssh start && echo Done.
fi
