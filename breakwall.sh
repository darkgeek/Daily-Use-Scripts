#!/bin/sh

pgrep privoxy > /dev/null
privoxy_running=$?

pgrep -x ssh > /dev/null
ssh_running=$?

if [ $privoxy_running = 0 ] && [ $ssh_running = 1 ]
then
	ssh -D 7777 linuxjustin@216.194.70.6
elif [ $privoxy_running = 1 ] && [ $ssh_running = 1 ]
then
	sudo /usr/local/etc/rc.d/privoxy forcestart
	ssh -D 7777 linuxjustin@216.194.70.6
else 
	echo "Don't know what to do. Is ssh running?"	
fi

