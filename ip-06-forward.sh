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
iptables -A INPUT -s 192.168.1.41 -j ACCEPT
iptables -A OUTPUT -d 192.168.1.41 -j ACCEPT

# Fer NAT per les xarxes:
# - 172.19.0.0/24
# - 172.20.0.0/24

iptables -t nat -A POSTROUTING -s 172.19.0.0/24 -o eno1 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 172.20.0.0/24 -o eno1 -j MASQUERADE


######################################################
#		  Exemples forward		     #
######################################################

# Prohibir que tots els hosts de la xarxa A puguin accedir a la xarxa B
# iptables -A FORWARD -s 172.19.0.0/24 -d 172.20.0.0/24 -j REJECT


# No permetre de xarxaA accedir al host B1
#iptables -A FORWARD -s 172.19.0.0/24 -d 172.20.0.2 -j REJECT

# Host A1 no pot accedir a res de B1
#iptables -A FORWARD -s 172.19.0.2 -d 172.20.0.2 -j REJECT

# Xarxa A té vetat accedir al port 13 de on sigui
#iptables -A FORWARD -s 172.19.0.0/24 -p tcp --dport 13 -j REJECT
#iptables -A FORWARD -i br-30dff169397f -p tcp --dport 13 -j REJECT

# Xarxa A no pot accedir al port 2013 de la Xarxa B
#iptables -A FORWARD -s 172.19.0.0/24 -d 172.20.0.0/24 -p tcp --dport 2013 -j REJECT

# Xarxa A pot navegar por internet, però not pot fer res més a l'exterior
#iptables -A FORWARD -s 172.19.0.0/24 -p tcp --dport 80 -o eno1 -j ACCEPT
#iptables -A FORWARD -d 172.19.0.0/24 -p tcp --sport 80 -i eno1 -m state --state ESTABLISHED,RELATED -j ACCEPT

#iptables -A FORWARD -s 172.19.0.0/24 -o eno1 -j DROP
#iptables -A FORWARD -d 172.19.0.0/24 -i eno1 -j DROP

# Xarxa A pot accedir a qualsevol port 2013 de totes les xarxes d'internet excepte la xarxa local 192.168.1.0/24

iptables -A FORWARD -s 172.19.0.0/24 -d 192.168.1.0/24 -p tcp --dport 2013 -j DROP

iptables -A FORWARD -s 172.19.0.0/24 -p tcp --dport 2013 -o eno1 -j ACCEPT

# Evitar que es falsifiqui la ip d'origen: SPOOFING

iptables -A FORWARD ! -s 172.19.0.0/24 -i br-30dff169397f -j DROP

