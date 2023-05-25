#!/usr/bin/bash

hostdev="enp6s18"
tapdev="tap0"
guestnet="10.0.1.1/24"

sudo ip link del ${tapdev} || true
sudo ip tuntap add ${tapdev} mode tap
sudo ip addr add ${guestnet} dev ${tapdev}
sudo ip link set ${tapdev} up
sudo iptables -t nat -A POSTROUTING -o ${hostdev} -j MASQUERADE
sudo iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i ${tapdev} -o ${hostdev} -j ACCEPT
