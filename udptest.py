import socket
import time
serverAddressPort = ("192.168.0.7", 0)

UDPClientSocket = socket.socket(family=socket.AF_INET, type = socket.SOCK_DGRAM)
for i in range(3000):
	print(UDPClientSocket.sendto(b'10100000', serverAddressPort))
	time.sleep(1)
