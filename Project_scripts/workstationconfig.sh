${cd /etc/sysconfig/network-scripts}
#copy a network script that ends in .2000
cp enp0s36.2000 to ifcfg-enpo0s36.2016
sudo vi ifcfg-enp0s36.2016
#from here use reg expressions to change all 2000 to 2016
systemctl restart network
vboxmanage cmds to adjust the new routers VM settings to be adapter 1 to bridged to network adapter and 2 adpater to internal as_net

