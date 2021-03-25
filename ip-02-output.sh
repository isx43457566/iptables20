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
iptables -A INPUT -s 192.168.1.80 -j ACCEPT
iptables -A OUTPUT -d 192.168.1.40 -j ACCEPT


# obrir la nostra ip
iptables -A INPUT -s 172.18.0.1 -j ACCEPT
iptables -A OUTPUT -d 172.18.0.1 -j ACCEPT

# obrir la nostra ip
#iptables -A INPUT -s 172.17.0.1 -j ACCEPT
#iptables -A OUTPUT -d 172.17.0.1 -j ACCEPT

# ===============================================
# denegar tot acceś exterior al port 13
#iptables -A OUTPUT -p tcp --dport 13 -j DROP

# accedir a tots el ports 13 de tot el món excepte del del nethost1 (172.18.0.2)
#iptables -A OUTPUT -p tcp --dport 13 -d 172.18.0.2 -j REJECT
#iptables -A OUTPUT -p tcp --dport 13 -j ACCEPT
# prohibir a la xarxa 172.18.0.2/24 accés al port 13 però permetre-ho al host2 i a tothom
#iptables -A OUTPUT -p tcp --dport 13 -d 172.18.0.3 -j ACCEPT
#iptables -A OUTPUT -p tcp --dport 13 -d 172.18.0.0/24 -j REJECT
#iptables -A OUTPUT -p tcp --dport 13 -j ACCEPT

# tancar accés al port 13 de h1 i h2
#iptables -A OUTPUT -p tcp --dport 13 -d 172.18.0.3 -j REJECT
#iptables -A OUTPUT -p tcp --dport 13 -d 172.18.0.2 -j REJECT
#iptables -A OUTPUT -p tcp --dport 13 -j ACCEPT

# denegar acces total als hosts h1 i h2 a qualsevol tipus de trafic
#iptables -A OUTPUT -d 172.18.0.3 -j DROP
#iptables -A OUTPUT -d 172.18.0.2 -j DROP
#iptables -A OUTPUT -d 13 -j ACCEPT

# denegar accés xarxes 172.18.0.0/24 i 172.19.0.2/24, la resta obert
iptables -A OUTPUT -d 172.18.0.0/24 -j REJECT
iptables -A OUTPUT -d 172.19.0.0/24 -j REJECT
iptables -A OUTPUT -d 0.0.0.0/0 -j ACCEPT

# prohibir al port 13 a tothom, permetre'l a la xarxa hisix2, denegar host1
iptables -A OUTPUT -p tcp --dport 13 -d 172.18.0.2 -j DROP
iptables -A OUTPUT -p tcp --dport 13 -d 172.18.0.0/24 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 13 -j DROP

# prohibir accés a la xarxa hisix2 excepte per ssh
iptables -A OUTPUT -p tcp --dport 22 -d 172.18.0.0/24 -j ACCEPT
iptables -A OUTPUT -d 172.18.0.0/24 -j DROP

                                                                              1,1      Comienzo


