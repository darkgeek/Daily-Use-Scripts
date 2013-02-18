#!/bin/sh

uname -a | grep -i linux > /dev/null
is_linux=$?

pgrep privoxy > /dev/null
privoxy_running=$?

pgrep -x ssh > /dev/null
ssh_running=$?

if [ $is_linux -eq 0 ]
then
	PRIVOXY_CMD="sudo /etc/rc.d/privoxy start"
else
	PRIVOXY_CMD="sudo /usr/local/etc/rc.d/privoxy onestart"
fi

if [ $privoxy_running = 0 ] && [ $ssh_running = 1 ]
then
	ssh -D 7777 linuxjustin@216.194.70.6
elif [ $privoxy_running = 1 ] && [ $ssh_running = 1 ]
then
	$PRIVOXY_CMD
	ssh -D 7777 linuxjustin@216.194.70.6
else 
	echo "Don't know what to do. Is ssh running?"	
fi

