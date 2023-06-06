#!/usr/bin/bash

hostdev="enp5s0"
tapdev="tap0"
guestnet="172.0.2.1/24"

sh -c "echo 1 > /proc/sys/net/ipv4/ip_forward"
ip link del ${tapdev} || true
ip tuntap add ${tapdev} mode tap
ip addr add ${guestnet} dev ${tapdev}
ip link set ${tapdev} up
iptables -t nat -A POSTROUTING -o ${hostdev} -j MASQUERADE
iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i ${tapdev} -o ${hostdev} -j ACCEPT
