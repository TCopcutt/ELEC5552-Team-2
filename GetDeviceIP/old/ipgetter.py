import os
import re

mac = input("Enter MAC address of device: ")
line = os.popen("arp -a | grep {}".format(mac)).read()
# 

if line:
	# pattern = re.compile(r'(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})'))
	# ip = pattern.search(line)[0]
	ip = re.findall("(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})", line)[0]
	ans = input("The device was found with the IP address {}\n Would you like to open the web configuration? [Y/n]".format(ip))
	if ans == "Y":
		os.system("open http://{}:80".format(ip))

else:
	print("Device could not be found on the network")

