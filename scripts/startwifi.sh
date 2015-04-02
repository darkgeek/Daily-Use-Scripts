#!/bin/sh

# Set IP Address of wlan0
sudo ifconfig wlan0 192.168.42.1

# Configure iptables firewall rules
sudo iptables -t nat -A POSTROUTING -o ppp0 -j MASQUERADE
sudo iptables -A FORWARD -i ppp0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i wlan0 -o ppp0 -j ACCEPT

# Start hostapd
sudo /home/justin/Apps/bin/hostapd -dd /etc/hostapd/hostapd.conf &

# Start udhcpd
sudo busybox udhcpd -fS /etc/udhcpd.conf
