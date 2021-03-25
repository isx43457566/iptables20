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

##################################################
#              Exemples established              #
##################################################

# Permetem accedir al servei daytime d'altres ordinadors
#iptables -A OUTPUT -p tcp --dport 13 -j ACCEPT
#iptables -A INPUT -p tcp --sport 13 -m state --state RELATED,ESTABLISHED -j ACCEPT

# Permetre actuar com a servidor daytime

iptables -A INPUT -p tcp --dport 13 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 13 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 13 -j DROP

# No es permet accedir a serveis daytime externs
iptables -A OUTPUT -p tcp --dport 13 -j DROP
iptables -A INPUT -p tcp --sport 13 -j DROP


