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
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP
iptables -t nat -P PREROUTING DROP
iptables -t nat -P POSTROUTING DROP

# obrir el localhost
iptables -A INPUT  -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# obrir la nostra ip
iptables -A INPUT -s 10.200.243.212 -j ACCEPT
iptables -A OUTPUT -d 10.200.243.212 -j ACCEPT

# ssh (22)
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT

# httpd (80, 443, 8080)
iptables -A INPUT -p tcp --dport 80 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 443 -j ACCEPT
iptables -A INPUT -p tcp --dport 8080 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 8080 -j ACCEPT

# dns (53)
iptables -A INPUT -p tcp --dport 53 -j ACCEPT
iptables -A INPUT -p udp --dport 53 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 53 -j ACCEPT
iptables -A OUTPUT -p udp --sport 53 -j ACCEPT

# smtp (25)
iptables -A INPUT -p tcp --dport 25 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 25 -j ACCEPT

# ldap (389, 636)
iptables -A INPUT -p tcp --dport 389 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 389 -j ACCEPT
iptables -A INPUT -p tcp --dport 636 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 636 -j ACCEPT

# kerberos (88, 464, 749)
iptables -A INPUT -p tcp --dport 88 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 88 -j ACCEPT
iptables -A INPUT -p tcp --dport 464 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 464 -j ACCEPT
iptables -A INPUT -p tcp --dport 749 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 749 -j ACCEPT

# telnet (23)
iptables -A INPUT -p tcp --dport 23 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 23 -j ACCEPT

# nfs (2049)
iptables -A INPUT -p tcp --dport 2049 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 2049 -j ACCEPT

# chronyd (123)
iptables -A INPUT -p udp --dport 123 -j ACCEPT
iptables -A OUTPUT -p udp --sport 123 -j ACCEPT

# postgresql (5432)
iptables -A INPUT -p tcp --dport 5432 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 5432 -j ACCEPT

# mongod (983)
iptables -A INPUT -p tcp --dport 983 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 983 -j ACCEPT




