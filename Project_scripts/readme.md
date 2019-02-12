Usage: Please run the main.sh and use the options given to deploy a Centos 7 router with wifi.

Physical Setup needed:
a VLAN adpater for particular student VLAN, this
A VM installed with CentOS-7
install git and clone this repo to the VM.
sudo yum -y install git


to start the automate configuation run sh main.sh from inside the repo directory as root.

Main.sh will present you with several options for setup which you can chose to install or not
Basic configuration: apply all updates and install needed applications
Netdev: will configure the network adpaters based on a student number
