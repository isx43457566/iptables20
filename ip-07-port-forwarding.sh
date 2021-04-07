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

# el forward ja està accept per defecte
#iptables -A FORWARD -p tcp --dport 13 -j REJECT
#iptables -A FORWARD -p tcp --sport 13 -j REJECT

# permetre al hosta1 fer de servidor daytime
iptables -A FORWARD -p tcp --dport 13 -d 172.18.0.2 -j ACCEPT
#iptables -A FORWARD -p tcp --sport 13 -d 172.18.0.2 -j ACCEPT -d 0.0.0.0/0 -m state --state RELATED,ESTABLISHED -j ACCEPT

# Fa NAT de la xarxa interna 172.18.0.0/24
iptables -t nat -A POSTROUTING -s 172.18.0.0/24 -o enp5s0 -j MASQUERADE

# Volem permetre desde l'exterior accedir al servei 13 de hosta1
# hem de fer port forwarding 5013 ------> 13 de hosta1
iptables -t nat -A PREROUTING -p tcp --dport 5013 -j DNAT --to 172.18.0.2:13

