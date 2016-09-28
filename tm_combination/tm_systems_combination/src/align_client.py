#!/usr/bin/python
#  -*- coding: latin-1 -*-
import sys
import socket


# Create a TCP/IP socket
clientsocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
# Connect the socket to the port on the server given by the caller
clientsocket.connect(('localhost', 8000))
sentence = open(sys.argv[1]).readlines()[0]


clientsocket.send(sentence)

result = clientsocket.recv(64*1024)


print(result)
clientsocket.close()
