#!/bin/bash
#===============================================================================
#
#          FILE:
#
#         USAGE:
#
#   DESCRIPTION:
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Aaron Jones, aj : ajones125@my.bcit.ca or aaronp.jones7@gmail.com
#  ORGANIZATION: BCIT - NASP STUDENT
#      REVISION:  ---
#===============================================================================
set -o nounset                              # Treat unset variables as an erro
#iptables commands
#should make sure the iptables service is running?
systemctl enable --now iptables
#Clear Rules
iptables -F
#input chain
iptables -I INPUT -i eth0 -p tcp --dport 22 -m state --state NEW -j ACCEPT
iptables -I INPUT -i eth0 -d 10.16.9.1 -p tcp --dport 22 -m state --state NEW -j ACCEPT
iptables -I INPUT -d 10.16.9.1 -m state --state NEW -j ACCEPT
iptables -I INPUT -i eth0 -p OSPF -m state --state NEW -j ACCEPT
iptables -I INPUT -i eth1 -p udp --dport 67 -m state --state NEW -j ACCEPT
iptables -I INPUT -i wlp0s6u1 -p udp --dport 67 -m state --state NEW -j ACCEPT
iptables -I INPUT -p udp --dport 53 -m state --state NEW -j ACCEPT
iptables -I INPUT -p ICMP -m state --state NEW -j ACCEPT
iptables -I INPUT -i lo -j ACCEPT
iptables -A INPUT -j LOG
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

#forward chain
iptables -I FORWARD -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

#output Chain
iptables -I OUTPUT -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
iptables -I OUTPUT -s 10.16.9.0/24 -m state --state NEW -j ACCEPT

#setting deafult policy to drop on all chains
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT DROP
#saves rules to make persistant
iptables-save > /etc/sysconfig/iptables

iptables -nvL
