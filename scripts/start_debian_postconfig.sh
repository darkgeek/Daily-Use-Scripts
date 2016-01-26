#!/bin/bash
echo Mount /proc...
mount -t proc none /proc && echo Done.

echo Mount /sys...
mount -t sysfs none /sys && echo Done.

echo Mount /dev...
mount -o bind /dev /dev && echo Done.

echo Mount /dev/pts...
mount -t devpts none /dev/pts && echo Done.

# Start VNC Server
echo Check if VNC Server is running...
vnc_server_count=`find /root/.vnc/ -name "*.pid" | wc -l`
if [ $vnc_server_count == 0 ]; then
    echo Starting VNC Server...
    vncserver -geometry 1024x768 && echo Done.
else
    echo VNC Server has been started previously.
fi

# Start SSHD
echo Check if sshd is running...
/etc/init.d/ssh status
if [ $? -ne 0 ]; then
    echo Well, looks not running, so start SSHD...
    /etc/init.d/ssh start && echo Done.
fi
