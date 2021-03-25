#! /bin/bash

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
iptables -A INPUT -s 10.200.243.212 -j ACCEPT
iptables -A OUTPUT -d 10.200.243.212 -j ACCEPT

#####################################################################

# INPUT
# -----
# 1)
# No es permet que els hosts de l’exterior (externs a l’organització) 
# accedeixin al servei daytime del router/firewall.
# Observar que des dels hosts A i B si és permet aquest accés. Perquè?


# OUTPUT
#-------
# 2)
# Des del router/firewall no es permet accés a cap serveu daytime exterior
# (extern a l’organització).
# Observeu que això no impedeix que des dels hosts A i B si que es pot
# accedir a aquest servei.

# 3)
# Tancar també l’accés del host B al servei daytime del router/firewall
# Observar que el host A encara ha de poder accedir al servei daytime del router/firewall.


# NAT
# ---
# 4)
# Implementar NAT de la xarxa interior. Verificar que els hosts A i B
# tenen connectivitat amb serveis externs.


# FORWARD
# -------
# 5)
# No es permet que el host A pugui accedir a serveis web (80) de l’exterior (externs a
# l’organització). Observar que si pot accedir al servei web de B i del router/firewall.

# 6)
# Permetre explícitament que el host B pugui accedir a serveis web de l’exterior
# i del router/firewall.


# PORT FORWARDING
# ---------------
# *Nota: observeu que en tots tres casos a part de la configuració del port forwarding
# cal la corresponent configuració de forwarding.
# 7)
# Configurar el port 2022 del router/firewall per accedir al servei ssh del host A.

# 8)
# Configurar el port 2013 del router/firewall per accedir al port 13 del host B.

# 9)
# Configurar el port 2080 del router/firewall per accedir al servei web del host A.


