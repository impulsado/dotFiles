#!/bin/bash

# Enable broadcast echo Protection
echo 1 > /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts

# Disable Source Routed Packets
for i in /proc/sys/net/ipv4/conf/*/accept_source_route; do
    echo 0 > $i
done

# Enable TCP SYN Cookie Protection
echo 1 > /proc/sys/net/ipv4/tcp_syncookies

# Disable ICMP Redirect Acceptance
for i in /proc/sys/net/ipv4/conf/*/accept_redirects; do
    echo 0 > $i
done

# Don't send Redirect Messages
for i in /proc/sys/net/ipv4/conf/*/send_redirects; do
    echo 0 > $i
done

# Drop Spoofed Packets coming in on an interface, which, if replied to,
# would result in the reply going out a different interface.
for i in /proc/sys/net/ipv4/conf/*/rp_filter; do
    echo 1 > $i
done