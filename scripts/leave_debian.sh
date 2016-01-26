#!/bin/bash

echo Stop SSHD...
/etc/init.d/ssh stop

echo Remove other stale pid files..
rm -rf /var/run/* && echo Done.

echo Clean /tmp...
rm -rf /tmp/* && rm -rf /tmp/.* && echo Done.
