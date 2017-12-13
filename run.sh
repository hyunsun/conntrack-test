#!/bin/bash

echo "======= building conntrack-test image  ======="
sudo docker build -t conntrack-test .

echo ""
echo ""
echo "======= native + command ======="
time sudo conntrack -D -f ipv4 -s 192.168.100.1 -w 1 -d 192.168.100.2

echo ""
echo "======= container + command ======="
sudo docker run -u root --rm --privileged conntrack-test ./conntrack_test.sh

echo ""
echo "======= native + python ======="
sudo python conntrack_test.py

echo ""
echo "======= container + python ======="
sudo docker run -u root --rm --privileged conntrack-test python conntrack_test.py

# run docker container interactive
#sudo docker run --rm -it -u root --privileged conntrack-test
