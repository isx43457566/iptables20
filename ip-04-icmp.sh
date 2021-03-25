#! /bin/bash
# @edt ASIX M11-SAD Curs 2018-2019
# iptables

#echo 1 > /proc/sys/net/ipv4/ip_forward

# Regles flush
iptables -F
iptables -X
iptables -Z
iptables -t nat -F

# Polítiques per defecte: 
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -t nat -P PREROUTING ACCEPT
iptables -t nat -P POSTROUTING ACCEPT

# obrir el localhost
iptables -A INPUT  -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# obrir la nostra ip
iptables -A INPUT -s 10.200.243.206 -j ACCEPT
iptables -A OUTPUT -d 10.200.243.206 -j ACCEPT

##############################################
#		Exemples ICMP		     #
##############################################

# No permeten fer pings
#iptables -A OUTPUT -p icmp --icmp-type 8 -j DROP
#iptables -A INPUT -p icmp --icmp-type 0 -j DROP

# No volem respondre a pings
iptables -A OUTPUT -p icmp --icmp-type 8 -d 10.200.243.228 -j DROP

iptables -A INPUT -p ticmp --itcmp-type 0 -d 10.200.243.228 -j DROP

iptables -A OUTPUT -p icmp --icmp-type 8 -j ACCEPT
iptables -A INPUT -p icmp --icmp-type 0 -j ACCEPT

