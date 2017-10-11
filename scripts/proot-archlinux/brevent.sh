#!/bin/bash

echo start adb...
export ANDROID_ADB_SERVER_PORT=12345
export ADB_LIBUSB=0
adb devices

echo start brevent server...
adb -e shell sh /data/data/me.piebridge.brevent/brevent.sh

echo stop adb...
adb kill-server

