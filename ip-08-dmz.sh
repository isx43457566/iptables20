#! /bin/bash
# @edt ASIX M11-SAD Curs 2018-2019
# iptables

#echo 1 > /proc/sys/ipv4/ip_forward

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
iptables -A INPUT -s 10.200.243.212 -j ACCEPT
iptables -A OUTPUT -d 10.200.243.212 -j ACCEPT

# configurar NAT per les xarxes 172.21.0.0/24 (neta) i 172.22.0.0/24 (netb) i 192.168.100.0/24
iptables -t nat -A POSTROUTING -s 172.21.0.0/24 -o enp5s0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 172.22.0.0/24 -o enp5s0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 192.168.100.0/24 -o enp5s0 -j MASQUERADE

# 1) xarxa neta només pot accedir del Router al daytime i ssh
#iptables -A INPUT -p tcp --dport 22 -s 172.21.0.0/24 -j ACCEPT
#iptables -A INPUT -p tcp -s 172.21.0.0/24 -j REJECT

# 2) xarxa neta cap a fora tot tancat excepte ports 13, 22 i 80
#iptables -A FORWARD -s 172.21.0.0/24 -p tcp --dport 13 -o enp5s0 -j ACCEPT
#iptables -A FORWARD -d 172.21.0.0/24 -p tcp --sport 13 -i enp5s0 -m state --state RELATED,ESTABLISHED -j ACCEPT
#iptables -A FORWARD -s 172.21.0.0/24 -o enp5s0 -j REJECT
#iptables -A FORWARD -d 172.21.0.0/24 -i enp5s0 -j REJECT

# KK) la xarxa neta només pot accedir a la DMZ
#iptables -A FORWARD -s 172.21.0.0/24 -d 192.168.100.0/24 -j ACCEPT
#iptables -A FORWARD -d 172.21.0.0/24 -s 192.168.100.0/24 -j ACCEPT
#iptables -A FORWARD -s 172.21.0.0/24 -j DROP
#iptables -A FORWARD -d 172.21.0.0/24 -j DROP

# 3) de la xarxa neta només es pot accedir dels serveis que ofereix la DMZ al servei web
#iptables -A FORWARD -s 172.21.0.0/24 -d 192.168.100.0/24 -p tcp --dport 80 -j ACCEPT
#iptables -A FORWARD -d 172.21.0.0/24 -s 192.168.100.0/24 -p tcp --sport 80 -m state --state RELATED,ESTABLISHED -j ACCEPT
#iptables -A FORWARD -s 172.21.0.0/24 -d 192.168.100.0/24 -j REJECT
#iptables -A FORWARD -d 172.21.0.0/24 -s 192.168.100.0/24 -j REJECT

# 4) redirigir els ports perquè des de l'exterior es tingui 
# accés a: 3001->hostA1:80, 3002->hostA2:13, 3003->hostB1:80,
# 3004->hostB2:13
iptables -A FORWARD -p tcp --dport 80 -d 172.21.0.2 -i enp5s0 -j ACCEPT
iptables -A FORWARD -p tcp --sport 80 -s 172.21.0.2 -i enp5s0 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -t nat -A PREROUTING -i enp5s0 -p tcp --dport 3001 -j DNAT --to 172.21.0.2:80

iptables -A FORWARD -p tcp --dport 13 -d 172.22.0.2 -i enp5s0 -j ACCEPT
iptables -A FORWARD -p tcp --sport 13 -s 172.22.0.2 -i enp5s0 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -t nat -A PREROUTING -i enp5s0 -p tcp --dport 3002 -j DNAT --to 172.22.0.2:13
iptables -t nat -A PREROUTING -i enp5s0 -p tcp --dport 3003 -j DNAT --to 172.22.0.2:13

# 5) S'habiliten els ports 4001 en endavant per accedir per ssh als ports ssh de:
# hostA1(4001), hostA2(4002), hostB1(4003), hostB2(4004).
 

