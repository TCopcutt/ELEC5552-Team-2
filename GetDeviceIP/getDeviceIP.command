#!/bin/bash
cd "$(dirname "$0")"
echo "Enter MAC address of device: "
read mac
line=$(arp -a | grep $mac)
ip=$(echo $line | grep -E -o '(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)')

if [[ $ip = "" ]]; then
	echo "The device could not be found. Ensure it is powered and connected to the network."
else
	echo "The device was found with the IP address $ip"
	echo "Would you like to open the web configuration? [Y/n]"
	read res
	if [[ $res = "Y" ]]; then
		open "http://$ip:80"
	fi
fi
echo "Exiting."