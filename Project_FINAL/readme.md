Usage:
  Please run the main.sh and use the options given to deploy a Centos 7 router with wifi or a mail server.

        eg. sudo sh main.sh

All service dependent values are stored in service specific folders in the SERVICENAMEVAR files respective to the service. .cnf files are service config files that will be copied to the target VM directories to run the service.

  (eg. DHCP: dhcp/ dhcp_setup.sh, dhcpvar - variables for the script, dhcp.cnf - conf file for the service)


                !! THIS SCRIPT WILL NOT RUN WITHOUT INTERNET !!

To decided between a router setup or a mail sever setup adjust the runformailsrv variables in the main.var file
      0 = router Setup
      1 = mail server setup

          !!! Please confirm the following before running running the script !!!

Router VM Setup:
  running OS: Centos 7
  1 wireless USB device attached to the VM
  At least 2 wired or ethernet network adapters attached to the VM
  An internet connection is assumed active on first run
  This script only handles 2 Ethernet adapters and 1 Wireless USB Adpater for network_setup at this moment. It is expandabled to handle more wired and wireless adapters, however another entry for ip addresse values is needed in the networkvar file.

Mail VM Setup:
  At least 1 wired or ethernet network adapters attached to the VM with internet connectivity.

The script will always run the following for both VM's:
    Install base software packages with updates
    Turn off selinux and firewalld
    Changes the hostname respective to the runformailsrv switch stored in main.var file
    Updates entire system

Depending on the runformailsrv variable in the main.var file it will use different values for the following:

    base install hostname
    network
    postfix
    dovecot setup
