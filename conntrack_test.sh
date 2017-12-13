#!/bin/bash

time conntrack -D -f ipv4 -s 192.168.100.1 -w 1 -d 192.168.100.2
