#!/bin/bash
iptables -A OUTPUT -d 8.8.8.8 -t mangle -j MARK --set-mark 0x3
iptables -A OUTPUT -d 8.8.8.8 -t mangle -j CONNMARK --save-mark
iptables -A PREROUTING -d 8.8.8.8 -t mangle -j MARK --set-mark 0x3
iptables -A PREROUTING -d 8.8.8.8 -t mangle -j CONNMARK --save-mark
echo "200 block" >> /etc/iproute2/rt_tables
ip rule add fwmark 0x3 table block
ip route add blackhole all table block
